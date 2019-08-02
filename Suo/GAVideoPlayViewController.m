//
//  GAVideoPlayViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/24.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAVideoPlayViewController.h"
#import "GAVideoPlayCell.h"
#import "GAAuthorViewController.h"

#import <TXLiteAVSDK_Player/TXVodPlayer.h>

@interface GAVideoPlayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TXVodPlayListener,GAVideoPlayCellDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)TXVodPlayer *player;
@property(nonatomic,strong) NSArray *urlList;

@property(nonatomic,strong)UIColor *originalColor;

@property(nonatomic,strong) id dataSource;
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation GAVideoPlayViewController

- (instancetype)initWith:(id)dataSource index:(NSInteger)currentIndex{
    if (self = [super init]) {
        _currentIndex = currentIndex;
        _dataSource = dataSource;
    }
    return self;
}

- (void)dealloc{
    [_player stopPlay];
    [_player removeVideoWidget];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _urlList = @[@"http://gajz.live.play.zsepoch.com/live/test_atangge.flv?txSecret=604bd314c34586e6c366f3beaf922bd7&txTime=5D3ED1B0",
                 @"http://1253131631.vod2.myqcloud.com/26f327f9vodgzp1253131631/f4c0c9e59031868222924048327/f0.mp4",
                 @"http://videoqiniu.laosiji.com/ZySuZqFj6MCC2a7uZsPTVzUzdBI=/Fi21D9NWMQqOrhqMbXlxdkRzitXa",
                 @"http://videoqiniu.laosiji.com/e6CRXo2_u_xJP6gOzJU6h6s8new=/Fg2fmesGFjdSeixACoikpFCOLUAK",
                 @"http://videoqiniu.laosiji.com/yohZP1E1q5Q-2_3UC7R-75sI2rE=/FgN7rui4MHgwiOrVgeUN8USFKIa2",
                 @"http://videoqiniu.laosiji.com/ybopElHe9eMNUgJSNqS8T35laqA=/ls15Xy3JyLy5lQ8naVpZAkpjMdGR",
                 @"http://videoqiniu.laosiji.com/ybopElHe9eMNUgJSNqS8T35laqA=/lnLE8Vlt0ThWELqdxT1KRzsd9PrL",
                 @"http://videoqiniu.laosiji.com/yohZP1E1q5Q-2_3UC7R-75sI2rE=/FiNXH9j7hJwfhy3NGt5a8JLB7oaG",
                 @"http://videoqiniu.laosiji.com/CehCoPRgYLCC2gwwNW32k7HxOk8=/lpeifLE_XpjLBE4NVZVGiaU3SA1N",
                 @"http://videoqiniu.laosiji.com/ybopElHe9eMNUgJSNqS8T35laqA=/lpXiRxWPwmlDLejKarTs5_7JnLCR",
                 @"http://videoqiniu.laosiji.com/ybopElHe9eMNUgJSNqS8T35laqA=/ln7ViwIoteWzOuUpBsImuYmQa_Xy",
                 @"http://videoqiniu.laosiji.com/CehCoPRgYLCC2gwwNW32k7HxOk8=/lmGIjRO7EuCKZW65zy-4HYc8uEiy",
                 @"http://videoqiniu.laosiji.com/ybopElHe9eMNUgJSNqS8T35laqA=/lmsi_n0BERbvf_clpkM686hURB3F"];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(moreButtonAction)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    [self.view setBackgroundColor:ColorGray];
    [self.view addSubview:self.collectionView];
    
    [self playVideoWithIndex:_currentIndex animated:NO];
    self.originalColor = self.navigationController.navigationBar.tintColor;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)moreButtonAction{
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];
    
    
    [self.player resume];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.player pause];
    [self.navigationController.navigationBar setTintColor:self.originalColor];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}


/**播放指定下标的视频*/
- (void)playVideoWithIndex:(NSInteger)index animated:(BOOL)animation {
    
    NSIndexPath *selectedItem = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView selectItemAtIndexPath:selectedItem animated:animation scrollPosition:UICollectionViewScrollPositionTop];
    
    
    __weak typeof(self) wself = self;
    GAVideoPlayCell*(^payCell)(void) = ^{
        [wself.player stopPlay];         //停止播放， 可以处理播放下一个视频时第一帧显示的是上一个视频
        [wself.player removeVideoWidget]; //移除，
        
        GAVideoPlayCell *cell = (GAVideoPlayCell*)[wself.collectionView cellForItemAtIndexPath:selectedItem];
        NSLog(@"cell -------0000000000000000000000000000000000>>>>> %@, indexpath=%@",cell,selectedItem);
        if (!cell) {
            [wself.collectionView layoutIfNeeded];
            cell = (GAVideoPlayCell*)[wself.collectionView cellForItemAtIndexPath:selectedItem];
            
            NSLog(@"layout 000000>>>>>>>>>>>>>>>>>>>>> %@",cell);
        }
        
        
        [wself.player setupVideoWidget:cell.contentView insertIndex:0];
        
        NSString *path = [self.urlList objectAtIndex:index];
        [wself.player startPlay:path];
        
        
        //[wself setPlayerStateDelegate:cell];
        
//        if (!wself.timer) {
////            wself.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
////                if ([wself.vodPlayer isPlaying]) {
////                    if ([wself.playerStateDelegate respondsToSelector:@selector(player:currentTime:totalTime:)]) {
////                        [wself.playerStateDelegate player:wself.vodPlayer currentTime:wself.vodPlayer.currentPlaybackTime totalTime:wself.vodPlayer.duration];
////                    }
////                }
////            }];
//        }
        return cell;
    };
    
    
    
    [UIView animateWithDuration:0.35 animations:^{
        
    } completion:^(BOOL finished) {
        GAVideoPlayCell *cell =  payCell();
        if (!cell) {
                //如果此时还没能获取cell  在一次延后0.35 确保显示出来 再获取
            [UIView animateWithDuration:0.35 animations:^{ } completion:^(BOOL finished) {
                payCell();
            }];
        }
    }];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.urlList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GAVideoPlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GAVideoPlayCell.identifier forIndexPath:indexPath];
    [cell setDelegate:self];
    return cell;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
   
    [self playVideoWithIndex:self.currentIndex animated:YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat page = scrollView.contentOffset.y / ScreenHeight;
    if (self.currentIndex != page) {
        self.currentIndex = page;
        [self playVideoWithIndex:self.currentIndex animated:YES];
    }
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        [layout setMinimumLineSpacing:0];
        [layout setMinimumInteritemSpacing:0];
        [layout setItemSize:UIScreen.mainScreen.bounds.size];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:ScreenBounds collectionViewLayout:layout];
        [_collectionView registerClass:GAVideoPlayCell.class forCellWithReuseIdentifier:GAVideoPlayCell.identifier];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setBackgroundColor:ColorBlack];
        [_collectionView setContentInset:UIEdgeInsetsZero];
        [_collectionView setPagingEnabled:YES];
        if (@available(iOS 11.0, *)) {
            [_collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        } else {
                // Fallback on earlier versions

        }
    }
    return _collectionView;
}

- (TXVodPlayer *)player{
    if (!_player) {
        _player = [[TXVodPlayer alloc] init];
        [_player setEnableHWAcceleration:YES];
        [_player setVodDelegate:self];
    }
    return _player;
}


#pragma mark -  XVodPlayListener

/**
 * 点播事件通知
 *
 * @param player 点播对象
 * @param EvtID 参见TXLiveSDKTypeDef.h
 * @param param 参见TXLiveSDKTypeDef.h
 * @see TXVodPlayer
 */
-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary*)param{
    
    switch (EvtID) {
                //播放完成
        case PLAY_EVT_PLAY_END:{
            
            //播放下一个
            if (self.currentIndex < self.urlList.count-1) {
                self.currentIndex += 1;
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
                [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
                //滚动结束后再播放
                
               // [self playVideoWithIndex:self.currentIndex animated:YES];
            }
        }break;
            
                //播放开始
        case PLAY_EVT_PLAY_BEGIN:{}break;
                //
            
            
        default:
            break;
    }
}

/**
 * 网络状态通知
 *
 * @param player 点播对象
 * @param param 参见TXLiveSDKTypeDef.h
 * @see TXVodPlayer
 */
-(void) onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary*)param{
    
}


#pragma mark - GAVideoPlayCellDelegate
- (void)cellDidClickUser:(GAVideoPlayCell *)cell{
    GAAuthorViewController *vc = GAAuthorViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
