//
//  GAOpenLiveControlView.m
//  Suo
//
//  Created by ysw on 2019/8/1.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAOpenLiveControlView.h"
#import <TZImagePickerController.h>


@interface GAOpenLiveControlView ()
@property(nonatomic,strong)UILabel *titleLabel;     //!<模式title
@property(nonatomic,strong)UIButton *modelTypeBtn;  //!<模式切换Btn
@property(nonatomic,strong)UIButton *switchCamera;  //!<切换相机

// info UI
@property(nonatomic,strong)UIView *containerView;               //!<元素容器
@property(nonatomic,strong)UIImageView *coverView;              //!<封面
@property(nonatomic,strong)UILabel *addCoverTitleLab;           //!<添加封面lab
@property(nonatomic,strong)UITextField *titleTextField;         //!<标题栏
@property(nonatomic,strong)UILabel *locationLab;                //!<位置信息
@property(nonatomic,strong)UILabel *shareLab;                   //!<分享Lab
@property(nonatomic,strong)UIToolbar *shareBar;                 //!<分享容器

// bottom ui
@property(nonatomic,strong)UIButton *beautyBtn;                 //!<美颜
@property(nonatomic,strong)UIButton *filterBtn;                 //!<滤镜
@property(nonatomic,strong)UIButton *startLiveBtn;              //!<开始直播


@end

@implementation GAOpenLiveControlView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    
    //top ui
    ({
        _titleLabel = [UILabel new];
        [_titleLabel setText:@"开播模式:"];
        [_titleLabel setFont:[MainFont fontWithSize:16]];
        [_titleLabel setTextColor:ColorWhite];
        
        _modelTypeBtn = UIButton.new ;
        [_modelTypeBtn setTitle:@"视频" forState:UIControlStateNormal];
        [_modelTypeBtn.titleLabel setFont:MainFontWithSize(14)];
        [_modelTypeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_modelTypeBtn setImagePosition:LXMImagePositionRight spacing:4];
        [_modelTypeBtn setBackgroundColor:RGBA(128, 128, 128, 1)];
        
        _switchCamera = UIButton.new;
        [_switchCamera setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_switchCamera setTitle:@"switch" forState:UIControlStateNormal];
        
        [self addSubview:_titleLabel];
        [self addSubview:_modelTypeBtn];
        [self addSubview:_switchCamera];
        
    });
    
    //info ui (分享，标题，封面等容器)
    ({
//        UIBlurEffect     *blur     = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
//        _containerView = [[UIVisualEffectView alloc] initWithEffect:vibrancy];
        _containerView = UIView.new;
        [_containerView.layer setCornerRadius:16];
        [_containerView.layer setMasksToBounds:YES];
        [_containerView setBackgroundColor:RGBA(127, 127, 127, 0.6)];
        
        _coverView = UIImageView.new;
        _addCoverTitleLab = UILabel.new;
        _titleTextField = UITextField.new;
        _locationLab = UILabel.new;
        _shareLab = UILabel.new;
        _shareBar = UIToolbar.new;
        
        [_containerView addSubview:_coverView];
        [_containerView addSubview:_addCoverTitleLab];
        [_containerView addSubview:_titleTextField];
        [_containerView addSubview:_locationLab];
        [_containerView addSubview:_shareLab];
        [_containerView addSubview:_shareBar];
        
        [self addSubview:_containerView];
        
        [_addCoverTitleLab setText:@"添加封面"];
        [_addCoverTitleLab setFont:MainFontWithSize(16)];
        [_addCoverTitleLab setTextAlignment:NSTextAlignmentCenter];
        [_addCoverTitleLab setTextColor:ColorWhite];
        
        [_titleTextField setPlaceholder:@""];
        NSDictionary *dict = @{NSFontAttributeName:MainFontWithSize(20),
                               NSForegroundColorAttributeName:ColorWhite,
                               };
        NSAttributedString *att = [[NSAttributedString alloc] initWithString:@"输入标题更吸粉😉" attributes:dict];
        [_titleTextField setAttributedPlaceholder:att];
        
        [_locationLab setFont:MainFontWithSize(14)];
        NSTextAttachment *imageText = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        [imageText setImage:[UIImage imageNamed:@"icon_home_like_after"]];
        [imageText setBounds:CGRectMake(0, 0, 24, 24)];
        
        NSMutableAttributedString *mutAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:imageText]];
        NSAttributedString *titleAtt = [[NSAttributedString alloc] initWithString:@" 开启定位,收获更多人气" attributes:@{NSForegroundColorAttributeName:ColorWhite,}];
        [mutAtt appendAttributedString:titleAtt];
        [_locationLab setAttributedText:mutAtt];
        
        
        [_shareLab setTextColor:ColorWhite];
        [_shareLab setText:@"分享精彩直播"];
        
        //share item
        UIBarButtonItem*(^shareItem)(NSString*,SEL) = ^(NSString*imageName,SEL sel){
            UIImage *image = [UIImage imageNamed:imageName];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:sel];
            //[item setTintColor:UIColor.whiteColor];
            [item setWidth:40];
            return item;
        };
        UIBarButtonItem *sina   = shareItem(@"icon_profile_share_wechat",@selector(shareToSina:));
        UIBarButtonItem *qq     = shareItem(@"icon_profile_share_qq",@selector(shareToQQ:));
        UIBarButtonItem *wechat = shareItem(@"icon_profile_share_wechat",@selector(shareToWeChat:));
        UIBarButtonItem *wechatTimline = shareItem(@"icon_profile_share_wxTimeline",@selector(shareToWeChatTimline:));
        [_shareBar setItems:@[sina,qq,wechat,wechatTimline] animated:YES];
        [_shareBar setBackgroundImage:UIImage.new forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [_shareBar setShadowImage:UIImage.new forToolbarPosition:UIBarPositionAny];
    

        [_coverView setBackgroundColor:UIColor.grayColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCoverImage:)];
        [_coverView setUserInteractionEnabled:YES];
        [_coverView addGestureRecognizer:tap];
    });
    
    //bottom UI
    ({
        _beautyBtn = UIButton.new;
        _filterBtn = UIButton.new;
        _startLiveBtn = UIButton.new;
        
        
        [_beautyBtn setTitle:@"美颜" forState:UIControlStateNormal];
        [_filterBtn setTitle:@"滤镜" forState:UIControlStateNormal];
        [_startLiveBtn setTitle:@"开启视频直播" forState:UIControlStateNormal];
        
        [_startLiveBtn.titleLabel setFont:MainFontWithSize(24)];
        [_startLiveBtn setBackgroundColor:RGBA(255, 78, 50, 1)];
        [_startLiveBtn.layer setCornerRadius:8];
        [_startLiveBtn.layer setMasksToBounds:YES];
        
        [self addSubview:_beautyBtn];
        [self addSubview:_filterBtn];
        [self addSubview:_startLiveBtn];
        
        [_startLiveBtn addTarget:self action:@selector(toggleStartButton:) forControlEvents:UIControlEventTouchUpInside];
    });
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //layout top ui
    ({
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(44);
            make.right.mas_equalTo(self.mas_centerX).inset(4);
        }];
        [self.modelTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX).inset(4);
            make.centerY.mas_equalTo(self.titleLabel);
            make.size.mas_equalTo(CGSizeMake(69, 30));
        }];
        [self.modelTypeBtn setupMaskWithCorner:15 rectCorner:UIRectCornerAllCorners];
        
        [self.switchCamera mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(self).inset(20);
        }];
        
    });
 
    //layout info UI
    ({
        [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).inset(12);
            make.top.mas_equalTo(self.modelTypeBtn.mas_bottom).inset(20);
            CGFloat h = (ScreenWidth - 24)*0.42;
            make.height.mas_equalTo(h);
        }];
        
        [self.coverView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.containerView).insets(UIEdgeInsetsMake(10, 26, 0, 0));
            make.size.mas_equalTo(CGSizeMake(90, 90));
            
        }];
        [self.addCoverTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.coverView);
        }];
        [self.titleTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.coverView);
            make.left.mas_equalTo(self.coverView.mas_right).inset(18);
            make.right.mas_equalTo(self).inset(26);
        }];
        [self.locationLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleTextField);
            make.bottom.mas_equalTo(self.coverView).inset(8);
        }];
        
        [self.shareLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverView);
            make.centerY.mas_equalTo(self.shareBar);
            //make.bottom.mas_equalTo(self.containerView).inset(18);
        }];
        [self.shareBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.left.mas_equalTo(self.shareLab.mas_right).inset(16);
            make.right.mas_equalTo(self.containerView).inset(4);
            make.bottom.mas_equalTo(self.containerView).inset(8);
            make.height.mas_equalTo(40);
        }];
    });
    
    
    //layout bottom ui
    ({
        [self.startLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 24, 0, 24));
            make.height.mas_equalTo(70);
        }];
        
        [self.beautyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_centerX).inset(50);
            make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(50);
        }];
        [self.filterBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX).inset(50);
            make.bottom.mas_equalTo(self.beautyBtn);
        }];
    });
}

- (void)toggleStartButton:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(startLive)]) {
        [self.delegate startLive];
    }
}

- (void)addCoverImage:(UITapGestureRecognizer*)tap{
    TZImagePickerController *picker = [[TZImagePickerController alloc] init];
    [picker setMaxImagesCount:1];
    
    [picker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self.coverView setImage:photos.firstObject];
    }];
    
    UIViewController *root = [UIApplication.sharedApplication keyWindow].rootViewController ;
    while (root.presentedViewController) {
        root = root.presentedViewController;
    }
    
    [root setDefinesPresentationContext:YES];
    [root presentViewController:picker animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.titleTextField resignFirstResponder];
}

- (void)shareToSina:(UIBarButtonItem*)send{
    
}
- (void)shareToQQ:(UIBarButtonItem*)send{
    
}
- (void)shareToWeChat:(UIBarButtonItem*)send{
    
}
- (void)shareToWeChatTimline:(UIBarButtonItem*)send{
    
}

@end
