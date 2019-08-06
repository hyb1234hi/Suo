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

@interface GALiveViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GALiveHeaderViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation GALiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    
    [GAAPI.new.videoAPI fetchLiveWithToken:@"4d909cb8c51cc6214cb6cc2bdc09aecc" completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        NSLog(@"sjon --- %@",json);
    }];
  
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    

    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GALiveCell *cell = (GALiveCell*) [collectionView dequeueReusableCellWithReuseIdentifier:GALiveCell.identifier forIndexPath:indexPath];
    [cell setBackgroundColor:UIColor.redColor];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        GALiveHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header setFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.58)];
        [header setDelegate:self];
        return header;
    }else{
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GALiveWatchViewController *vc =  [[GALiveWatchViewController alloc] initWithDataSource:@"" indexPath:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        CGFloat rate = 410.0 / 414;
        CGFloat w = ScreenWidth;
        CGFloat h = w * rate;
        [layout setItemSize:CGSizeMake(w, h)];
        [layout setMinimumInteritemSpacing:4.0];
        [layout setHeaderReferenceSize:CGSizeMake(ScreenWidth, ScreenWidth*0.58)];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:GALiveCell.class forCellWithReuseIdentifier:GALiveCell.identifier];
        [_collectionView registerClass:GALiveHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
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
