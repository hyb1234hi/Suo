//
//  GAAuthorViewController.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAAuthorViewController.h"
#import "GAAuthorHeaderView.h"
#import "GAVideoPlayViewController.h"
#import "GAFansAndFollowViewController.h"
#import "GAAuthorVideoCell.h"

@interface GAAuthorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GAAuthorHeaderViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation GAAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"滑板鞋"];
    [self.view addSubview:self.collectionView];
    
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    [self.navigationItem setRightBarButtonItem:share];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GAVideoPlayViewController *vc = [[GAVideoPlayViewController alloc] initWith:@"" index:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GAAuthorVideoCell* cell = (GAAuthorVideoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:GAAuthorVideoCell.identifier forIndexPath:indexPath];
    [cell setBackgroundColor:UIColor.redColor];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        GAAuthorHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header setDelegate:self];
        
        
        return header;
    }
    return nil;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        [layout setMinimumLineSpacing:1];
        [layout setMinimumInteritemSpacing:1];
        CGFloat w = (ScreenWidth - 2 ) / 3;
        CGFloat h = w ;
        [layout setItemSize:CGSizeMake(w, h)];
        [layout setHeaderReferenceSize:CGSizeMake(ScreenWidth, ScreenWidth*0.7)];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:GAAuthorVideoCell.class forCellWithReuseIdentifier:GAAuthorVideoCell.identifier];
        [_collectionView registerClass:GAAuthorHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setBackgroundColor:UIColor.whiteColor];
    }
    return _collectionView;
}


#pragma mark - GAAuthorHeaderViewDelegate (头视图按钮事件代理)
- (void)headerViewFansListClick:(GAAuthorHeaderView*)view{
    GAFansAndFollowViewController *vc = [[GAFansAndFollowViewController alloc] initWithType:ViewControllerTypeFans];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)headerViewFollowListClick:(GAAuthorHeaderView*)view{
    GAFansAndFollowViewController *vc = [[GAFansAndFollowViewController alloc] initWithType:ViewControllerTypeFollow];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)headerViewHotClick:(GAAuthorHeaderView*)view{}
- (void)headerViewFollowAuthorClick:(GAAuthorHeaderView*)view{}
- (void)headerViewAvatarClick:(GAAuthorHeaderView*)view{}

@end
