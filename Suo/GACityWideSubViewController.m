//
//  GACityWideSubViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACityWideSubViewController.h"
#import "GACityWideCollectionCell.h"
#import "GAVideoPlayViewController.h"

#import <XRWaterfallLayout.h>

@interface GACityWideSubViewController ()<
UICollectionViewDelegate,UICollectionViewDataSource,
XRWaterfallLayoutDelegate,GACityWideCollectionCellDelegate
>
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation GACityWideSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GACityWideCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GACityWideCollectionCell.identifier forIndexPath:indexPath];
    [cell setDelegate:self];
    
    
    [cell setBackgroundColor:UIColor.redColor];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GAVideoPlayViewController *vc = [[GAVideoPlayViewController alloc] initWith:@"" index:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    //判断视频类型 或者 直播类型
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        XRWaterfallLayout *layout = [[XRWaterfallLayout alloc] initWithColumnCount:2];
        [layout setColumnSpacing:6 rowSpacing:6 sectionInset:UIEdgeInsetsZero];
        [layout setDelegate:self];
        [layout setSectionInset:UIEdgeInsetsMake(0, 6, 0, 6)];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:ScreenBounds collectionViewLayout:layout];
        [_collectionView registerClass:GACityWideCollectionCell.class forCellWithReuseIdentifier:GACityWideCollectionCell.identifier];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        //[_collectionView setContentInset:UIEdgeInsetsMake(0, 6, 0, 6)];
        [_collectionView setBackgroundColor:ColorWhite];
    }
    return _collectionView;
}


#pragma mark - XRWaterfallLayoutDelegate
    //根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
        //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示
    
    if (indexPath.row == 0) {
        return itemWidth * 1.35;
    }else{
        return itemWidth * 1.6;
    }
}


#pragma mark - GACityWideCollectionCellDelegate
- (void)deleteItem:(GACityWideCollectionCell *)cell{
    //删除本地item 数据，跟新cell
    //NSLog(@"delete -- %@",cell);
}
@end
