//
//  GAVideoViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/24.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAVideoViewController.h"
#import "GAVideoPlayViewController.h"
#import "GAAuthorViewController.h"
#import "GAVideoCell.h"


@interface GAVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GAVideoCellDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation GAVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@""];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        } else {
                // Fallback on earlier versions
        }
    }];
}

#pragma mark - GAVideoCellDelegate
- (void)cellDidClickAvatar:(GAVideoCell *)cell{
    GAAuthorViewController *vc = [[GAAuthorViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GAVideoPlayViewController *vc = [[GAVideoPlayViewController alloc] initWith:@"" index:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GAVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GAVideoCell.identifier forIndexPath:indexPath];
    [cell setBackgroundColor:UIColor.redColor];
    [cell setDelegate:self];
    
    return cell;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat spacing = 4;
        CGFloat raw = 2;
        CGFloat w = CGRectGetWidth(UIScreen.mainScreen.bounds) - spacing *(raw+1);
        w = w/raw;
        CGFloat h = w * 1.56;
        [layout setItemSize:CGSizeMake(w, h)];
        [layout setMinimumInteritemSpacing:spacing];
        [layout setMinimumLineSpacing:spacing];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:UIScreen.mainScreen.bounds collectionViewLayout:layout];
        [_collectionView registerClass:GAVideoCell.class forCellWithReuseIdentifier:GAVideoCell.identifier];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setBackgroundColor:UIColor.whiteColor];
        [_collectionView setContentInset:UIEdgeInsetsMake(spacing, spacing, spacing, spacing)];
    }
    return _collectionView;
}

@end
