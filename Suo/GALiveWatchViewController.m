//
//  GALiveWatchViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveWatchViewController.h"
#import "GALiveWatchCell.h"
#import "GAAuthorViewController.h"

#import <TXLiteAVSDK_Player/TXLivePlayer.h>

@interface GALiveWatchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GALiveWatchCellDelegate>

@property(nonatomic,strong) UIToolbar *toolbar;
@property(nonatomic,strong) UIView *userView;


@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) TXLivePlayer *livePlayer;
@property(nonatomic,assign) NSInteger currentIndex;
@end

@implementation GALiveWatchViewController


- (instancetype)initWithDataSource:(id)dataSource indexPath:(NSInteger)index{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@""];
    [self.view addSubview:self.collectionView];
    
   // [self.navigationItem setTitleView:self.toolbar];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - GALiveWatchCellDelegate
- (void)clickUserWithCell:(GALiveWatchCell *)cell{
    GAAuthorViewController *vc = GAAuthorViewController.new;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GALiveWatchCell *cell = (GALiveWatchCell*)[collectionView dequeueReusableCellWithReuseIdentifier:GALiveWatchCell.identifier forIndexPath:indexPath];
    
    [cell setBackgroundColor:UIColor.grayColor];
    [cell setDelegate:self];
    
    return cell;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        [layout setItemSize:ScreenBounds.size];
        [layout setMinimumInteritemSpacing:0];
        [layout setMinimumLineSpacing:0];
        
        
        _collectionView  = [[UICollectionView alloc] initWithFrame:ScreenBounds collectionViewLayout:layout];
        [_collectionView registerClass:GALiveWatchCell.class forCellWithReuseIdentifier:GALiveWatchCell.identifier];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setBackgroundColor:ColorWhite];
        //[_collectionView setPagingEnabled:YES];
        
        if (@available(iOS 11.0, *)) {
            [_collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        } else {
                // Fallback on earlier versions
        
        }
        
    }
    return _collectionView;
}



- (UIToolbar *)toolbar{
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        [_toolbar setShadowImage:UIImage.new forToolbarPosition:UIBarPositionAny];
        [_toolbar setBackgroundImage:UIImage.new forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        
        UIView *view = self.userView;
        [view setFrame:CGRectMake(0, 0, 80, 40)];
        
        UIBarButtonItem *avatarItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        [avatarItem setWidth:126];
        
        UIImage *image = [UIImage imageNamed:@"icon_profile_share_qq"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
//        [avatarItem setImage:image];
//        [avatarItem setTitle:@"title"];
        
        UIButton *followBtn = UIButton.new;
        [followBtn setTitle:@"关注" forState:UIControlStateNormal];
        [followBtn setTitle:@"已经关注" forState:UIControlStateSelected];
        [followBtn setFrame:CGRectMake(0, 0, 60, 40)];
        [followBtn setBackgroundColor:UIColor.redColor];
        [followBtn setupMaskWithCorner:20 rectCorner:UIRectCornerAllCorners];
        [followBtn.titleLabel setFont:[MainFont fontWithSize:16]];
        
        UIBarButtonItem *followItem = [[UIBarButtonItem alloc] initWithCustomView:followBtn];
        
        UIBarButtonItem *user1 = UIBarButtonItem.new;
        user1.image = image;
        [user1 setWidth:40];
        
        UIBarButtonItem *user2 = UIBarButtonItem.new;
        user2.image = image;
        
        
        
        [_toolbar setItems:@[avatarItem,followItem,user1,user2] animated:YES];
        
    }
    return _toolbar;
}

- (UIView *)userView{
    if (!_userView) {
        _userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        
        UIImageView *avatarView = UIImageView.new;
        [avatarView setImage:[UIImage imageNamed:@"icon_profile_share_qq"]];
        
        UILabel *name = UILabel.new;
        [name setText:@"userName"];
        [name setFont:[MainFont fontWithSize:16]];
        
        
        UILabel *fire = UILabel.new;
        [fire setText:@"666万火力"];
        [fire setFont:[MainFont fontWithSize:14]];
        
        [_userView addSubview:avatarView];
        [_userView addSubview:name];
        [_userView addSubview:fire];
        
        [avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(self->_userView);
            make.width.mas_equalTo(avatarView.mas_height);
        }];
        
        [name mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(avatarView.mas_right).inset(4);
            make.bottom.mas_equalTo(avatarView.mas_centerY).inset(2);
        }];
        [fire mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(avatarView.mas_right).inset(4);
            make.top.mas_equalTo(avatarView.mas_centerY).inset(2);
        }];
        
    }
    return _userView;
}

@end
