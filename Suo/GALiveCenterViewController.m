//
//  GALiveCenterViewController.m
//  Suo
//
//  Created by ysw on 2019/8/11.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveCenterViewController.h"
#import "GAOpenLiveViewController.h"

#import "GALiveCenterProfileView.h"
#import "GALiveCenterHeaderView.h"

@interface GALiveCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,
GALiveCenterProfileViewDelegate
>
@property(nonatomic,strong)UICollectionView *collecitonView;

@end


static NSString *const firstSectionHeader   = @"firstSectionHeader";
static NSString *const otherSectionHeader   = @"otherSectionHeader";
static NSString *const sectionFooter        = @"sectionFooter";

@implementation GALiveCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collecitonView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.collecitonView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - getter
- (UICollectionView *)collecitonView{
    if (!_collecitonView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        [layout setMinimumLineSpacing:6];
        
        _collecitonView =  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collecitonView setBackgroundColor:UIColor.clearColor];
        [_collecitonView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
        
        NSString *header = UICollectionElementKindSectionHeader;
        NSString *footer = UICollectionElementKindSectionFooter;
        
        [_collecitonView registerClass:GALiveCenterProfileView.class forSupplementaryViewOfKind:header withReuseIdentifier:firstSectionHeader];
        [_collecitonView registerClass:GALiveCenterHeaderView.class forSupplementaryViewOfKind:header withReuseIdentifier:otherSectionHeader];
        [_collecitonView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:footer withReuseIdentifier:sectionFooter];
        
        
        [_collecitonView setDataSource:self];
        [_collecitonView setDelegate:self];
    }
    return _collecitonView;
}

#pragma mark - UICollectionView DataSource,delegate, delegateLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 0;
        }break;
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:UIColor.blueColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        switch (indexPath.section) {
            case 0:{
                GALiveCenterProfileView *profile = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:firstSectionHeader forIndexPath:indexPath];
                [profile setDelegate:self];
        
                return profile;
            }break;
                
            default:{
                GALiveCenterHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:otherSectionHeader forIndexPath:indexPath];
                
                return header;
                
            }break;
        }
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionFooter forIndexPath:indexPath];
        [footer setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
        
        return footer;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ScreenWidth, 180);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return CGSizeMake(ScreenWidth, ScreenWidth*(192/414.0));
            break;
            
        default:
            return CGSizeMake(ScreenWidth, 60);
            break;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, 11);
}


#pragma mark -  GALiveCenterProfileViewDelegate  (头部按钮 点击事件 代理)
- (void)profileViewDidClickOpenLiveButton{
//    GAOpenLiveViewController *open = GAOpenLiveViewController.new;
//
//    [self setDefinesPresentationContext:YES];
//    [self presentViewController:open animated:YES completion:nil];
    [self.tabBarController setSelectedIndex:2];
}
- (void)profileViewDidClickPublishButton{
    
}

@end
