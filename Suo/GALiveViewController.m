//
//  GALiveViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveViewController.h"
#import "GALiveWatchViewController.h"

#import "GALiveTopCell.h"
#import "GALiveCell.h"
#import "GALiveTableCell.h"
#import "GALiveHeaderView.h"
#import "GALiveSectionTitleView.h"

#import "GAAPI.h"
#import "GALiveRecommendData.h"
#import "GATopListData.h"
#import "GAFollowLiveListData.h"
#import "GAAllTypeLiveData.h"

@interface GALiveViewController ()<
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,
GALiveHeaderViewDelegate
>


@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray<GABaseDataSource*> *dataSourceList;   //!<节数量

@property(nonatomic,strong)NSMutableArray<GALiveType*> *liveTypeList;           //!<live类型


//数据源
@property(nonatomic,strong)GALiveRecommendData *recommendData;  //!<推荐数据
@property(nonatomic,strong)GATopListData *topListData;          //!<排行榜数据
@property(nonatomic,strong)GAFollowLiveListData *followLiveData;//!<关注数据

//@property(nonatomic,strong)NSMutableArray<GABaseDataSource*> *allTypeDataList;  //所有类型列表

@end

@implementation GALiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    
    [self reloadAllData];
}

/**
 刷新所有数据源
 */
- (void)reloadAllData{
    
    _dataSourceList = @[].mutableCopy;
    //_allTypeDataList = @[].mutableCopy;
    
    _topListData    = GATopListData.new;
    _recommendData  = GALiveRecommendData.new;
    
    
    [_dataSourceList addObject:_topListData];
    [_dataSourceList addObject:_recommendData];
    
    //用户已经登录 添加关注列表数据
    if (self.loginKey.length > 0) {
        _followLiveData = [[GAFollowLiveListData alloc] initWithUserKey:self.loginKey];
        [_dataSourceList addObject:_followLiveData];
        [_followLiveData reloadDataWithCompletion:^(NSArray *lives) {
            if (lives.count > 0) {
                [self reloadSectionForSource:self.followLiveData];
            }
        }];
    }
    
    
    // load data
    [_recommendData reloadDataWithCompletion:^(NSArray *lives) {
        if (lives.count > 0) {
            [self reloadSectionForSource:self.recommendData];
        }
    }];
    [_topListData reloadDataWithCompletion:^(NSArray *lives) {}];
    
    //分类直播数据
    [GAAPI.new.videoAPI fetchLiveTypeCompletion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
    
        if ([json valueForKey:@"datas"]) {
            NSMutableArray<GALiveType*> *allType = @[].mutableCopy;
            NSArray *tmp = [json valueForKey:@"datas"];
            for (NSDictionary *dict in tmp) {
                [allType addObject:[GALiveType instanceWithDict:dict]];
            }
            self.liveTypeList = allType; //保存分类数据
            
            // NOTE 注意这部分的数据刷新顺序
            // 01setp 添加section     ->刷新ColletionView
            // 02setp 添加sectionItem ->刷新section
            
            for (GALiveType *type in allType) {
                GAAllTypeLiveData *typeData = [[GAAllTypeLiveData alloc] initWithType:type];
                [self.dataSourceList addObject:typeData];
                [typeData reloadDataWithCompletion:^(NSArray *lives) {
                    if (lives.count>0) {
                         [self reloadSectionForSource:typeData];        //02 setp
                    }
                }];
            }
            [self.collectionView reloadData];   // 01 setp
        }
    }];
}
- (void)reloadSectionForSource:(GABaseDataSource*)dataSource{
    NSInteger index = [self.dataSourceList indexOfObject:dataSource];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, 1)]];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSourceList.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    GABaseDataSource *dataSource = [self.dataSourceList objectAtIndex:section];
    
    switch (section) {
        case 0:{
            //第一节只显示头部信息栏
            return 1;
        }break;
        
        default:
            return dataSource.liveItems.count;
            break;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GALiveTopCell*(^firstSectionCell)(void) = ^{
        GALiveTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GALiveTopCell.identifier forIndexPath:indexPath];
        
        
        return cell;
    };
    
    GALiveCell*(^otherCell)(void) = ^{
        GALiveCell *cell = (GALiveCell*) [collectionView dequeueReusableCellWithReuseIdentifier:GALiveCell.identifier forIndexPath:indexPath];
        [cell setBackgroundColor:UIColor.redColor];
        [cell setupMaskWithCorner:5 rectCorner:UIRectCornerAllCorners];
        
        GABaseDataSource *datasource = [self.dataSourceList objectAtIndex:indexPath.section];
        [cell setLiveItem:datasource.liveItems[indexPath.row]];
        
        return cell;
    };
    
    if (indexPath.section == 0) {
        return firstSectionCell();
    }else{
        return otherCell();
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //第一节节头
        UICollectionReusableView*(^firstSection)(void) = ^{
            GALiveHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                          withReuseIdentifier:@"firstHeader"
                                                                                 forIndexPath:indexPath];
            [header setDelegate:self];
            return header;
        };
        
        //其他节
        UICollectionReusableView*(^otherSectin)(void) = ^{
            GALiveSectionTitleView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                withReuseIdentifier:@"secHeader"
                                                                                       forIndexPath:indexPath];
           
            GABaseDataSource *dataSource = self.dataSourceList[indexPath.section];
            [view.titleLabel setText:dataSource.title];
            
            return view;
        };
        
        if (indexPath.section == 0) {
            return firstSection();
        }else{
            return otherSectin();
        }
        
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:@"footer"
                                                                                     forIndexPath:indexPath];
        [footer setBackgroundColor:RGBA(248, 248, 248, 1)];
        
        return footer;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GALiveWatchViewController *vc =  [[GALiveWatchViewController alloc] initWithDataSource:@"" indexPath:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(ScreenWidth, ScreenWidth*(125/392.0));
    }
    return CGSizeMake(ScreenWidth, 60);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, 17);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(ScreenWidth, 44.0);
            break;
            
        default:{
            CGFloat space = 12.0;
            
            CGFloat rate = 289/174.0;  //  h=289 / w =174.0      //宽高比
            
            CGFloat w = (ScreenWidth-space*3)/2.0;    //两列
            CGFloat h = w * rate;
            return CGSizeMake(w, h);
        }break;
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        CGFloat space = 12;

        [layout setMinimumInteritemSpacing:space];
        [layout setSectionInset:UIEdgeInsetsMake(0, space, space, space)];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_collectionView registerClass:GALiveCell.class forCellWithReuseIdentifier:GALiveCell.identifier];
        [_collectionView registerClass:GALiveTopCell.class forCellWithReuseIdentifier:GALiveTopCell.identifier];
        
        NSString *header = UICollectionElementKindSectionHeader;
        NSString *footer = UICollectionElementKindSectionFooter;
        [_collectionView registerClass:GALiveHeaderView.class forSupplementaryViewOfKind:header withReuseIdentifier:@"firstHeader"];
        [_collectionView registerClass:GALiveSectionTitleView.class forSupplementaryViewOfKind:header withReuseIdentifier:@"secHeader"];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:footer withReuseIdentifier:@"footer"];
        
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setBackgroundColor:ColorWhite];
    }
    return _collectionView;
}

#pragma mark - GALiveHeaderViewDelegate
- (void)menuView:(WMMenuView *)menuView selectedIndex:(NSUInteger)index{
    //刷新数据源
   // NSLog(@"index -- %d",index);
}

@end
