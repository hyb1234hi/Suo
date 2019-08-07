//
//  GALiveViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveViewController.h"
#import "GALiveWatchViewController.h"

#import "GALiveCell.h"
#import "GALiveTableCell.h"
#import "GALiveHeaderView.h"

#import "GAAPI.h"

@interface GALiveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GALiveHeaderViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation GALiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    
    
    //获取 cookie keyValue
    NSString *key = nil;
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        if ([[cookie.properties valueForKey:NSHTTPCookieName] isEqualToString:@"key"]) {
            key = [cookie.properties valueForKey:NSHTTPCookieValue];
        }
    }
    
    [GAAPI.new.videoAPI fetchLiveWithToken:key completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        //NSLog(@"sjon --- %@",json);
    }];
  
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GALiveCell *cell = (GALiveCell*) [collectionView dequeueReusableCellWithReuseIdentifier:GALiveCell.identifier forIndexPath:indexPath];
    [cell setBackgroundColor:UIColor.redColor];
    
    return cell;
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
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                withReuseIdentifier:@"secHeader"
                                                                                       forIndexPath:indexPath];
            
            return view;
        };
        
        switch (indexPath.section) {
            case 0:{
                return firstSection();
            }break;
                
            default:
                return  otherSectin();
                break;
        }
        
    }else{
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GALiveWatchViewController *vc =  [[GALiveWatchViewController alloc] initWithDataSource:@"" indexPath:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(ScreenWidth, ScreenWidth*(180.0/414.0));
    }
    
    return CGSizeMake(ScreenWidth, 60);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        CGFloat space = 12;
        
        CGFloat rate = 289/174;  // h /w
        
        CGFloat w = (ScreenWidth-27*2-space)/2;
        CGFloat h = w * rate;
        [layout setItemSize:CGSizeMake(w, h)];
        [layout setMinimumInteritemSpacing:4.0];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_collectionView registerClass:GALiveCell.class forCellWithReuseIdentifier:GALiveCell.identifier];
        
        [_collectionView registerClass:GALiveHeaderView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"firstHeader"];
        
        [_collectionView registerClass:UICollectionReusableView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"secHeader"];
        
        
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setBackgroundColor:ColorWhite];
        //[_collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    
    
    }
    return _collectionView;
}

#pragma mark - GALiveHeaderViewDelegate
- (void)menuView:(WMMenuView *)menuView selectedIndex:(NSUInteger)index{
    //刷新数据源
   // NSLog(@"index -- %d",index);
}

@end
