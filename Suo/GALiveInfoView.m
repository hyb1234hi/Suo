//
//  GALiveInfoView.m
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveInfoView.h"
#import <TZImagePickerController.h>
#import <CoreLocation/CoreLocation.h>

@interface GALiveInfoView ()<CLLocationManagerDelegate>
@property(nonatomic,strong)UIImageView *coverView;              //!<封面
@property(nonatomic,strong)UILabel *addCoverTitleLab;           //!<添加封面lab
@property(nonatomic,strong)UITextField *titleTextField;         //!<标题栏
@property(nonatomic,strong)UILabel *locationLab;                //!<位置信息
@property(nonatomic,strong)UILabel *shareLab;                   //!<分享Lab
@property(nonatomic,strong)UIToolbar *shareBar;                 //!<分享容器

@property(nonatomic,strong)CLLocationManager *manager;
@end

@implementation GALiveInfoView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        [self.layer setCornerRadius:16];
        [self.layer setMasksToBounds:YES];
        [self setBackgroundColor:ColorBlackAlpha40];
    }
    return self;
}

- (void)setupUI{
    
    _coverView = UIImageView.new;
    _addCoverTitleLab = UILabel.new;
    _titleTextField = UITextField.new;
    _locationLab = UILabel.new;
    _shareLab = UILabel.new;
    _shareBar = UIToolbar.new;
    
    [self addSubview:_addCoverTitleLab];
    [self addSubview:_coverView];
    [self addSubview:_titleTextField];
    [self addSubview:_locationLab];
    [self addSubview:_shareLab];
    [self addSubview:_shareBar];
    
    [_addCoverTitleLab setText:@"添加封面"];
    [_addCoverTitleLab setFont:MainFontWithSize(13)];
    [_addCoverTitleLab setTextAlignment:NSTextAlignmentCenter];
    [_addCoverTitleLab setTextColor:ColorWhite];
    
    [_titleTextField setPlaceholder:@""];
    NSDictionary *dict = @{NSFontAttributeName:MainFontWithSize(19),
                           NSForegroundColorAttributeName:ColorWhite,
                           };
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:@"输入标题更吸粉😉" attributes:dict];
    [_titleTextField setAttributedPlaceholder:att];
    
    [_locationLab setFont:MainFontWithSize(12)];
    [_locationLab setTextColor:ColorWhite];
    NSTextAttachment *imageText = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    [imageText setImage:[UIImage imageNamed:@"icon_home_like_after"]];
    [imageText setBounds:CGRectMake(0, 0, 24, 24)];
    
    NSMutableAttributedString *mutAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:imageText]];
    NSAttributedString *titleAtt = [[NSAttributedString alloc] initWithString:@" 开启定位,收获更多人气" attributes:@{NSForegroundColorAttributeName:ColorWhite,}];
    [mutAtt appendAttributedString:titleAtt];
    [_locationLab setAttributedText:mutAtt];
    UITapGestureRecognizer *tapLocatin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fetchLocation:)];
    [_locationLab addGestureRecognizer:tapLocatin];
    [_locationLab setUserInteractionEnabled:YES];
    
    [_shareLab setTextColor:ColorWhite];
    [_shareLab setText:@"分享精彩直播"];
    [_shareLab setFont:MainFontWithSize(15)];
    
        //share item
    UIBarButtonItem*(^shareItem)(NSString*,SEL) = ^(NSString*imageName,SEL sel){
        UIImage *image = [UIImage imageNamed:imageName];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:sel];
            //[item setTintColor:UIColor.whiteColor];
        [item setWidth:30];
        return item;
    };
    UIBarButtonItem *sina   = shareItem(@"icon_profile_share_wechat",@selector(shareToSina:));
    UIBarButtonItem *qq     = shareItem(@"icon_profile_share_qq",@selector(shareToQQ:));
    UIBarButtonItem *wechat = shareItem(@"icon_profile_share_wechat",@selector(shareToWeChat:));
    UIBarButtonItem *wechatTimline = shareItem(@"icon_profile_share_wxTimeline",@selector(shareToWeChatTimline:));
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [_shareBar setItems:@[sina,space,qq,space,wechat,space,wechatTimline] animated:YES];
    [_shareBar setBackgroundImage:UIImage.new forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [_shareBar setShadowImage:UIImage.new forToolbarPosition:UIBarPositionAny];
    
    
    [_coverView setBackgroundColor:ColorBlackAlpha60];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCoverImage:)];
    [_coverView setUserInteractionEnabled:YES];
    [_coverView addGestureRecognizer:tap];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.coverView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).insets(UIEdgeInsetsMake(18, 35, 0, 0));
        make.size.mas_equalTo(CGSizeMake(80, 80));
        
    }];
    [self.addCoverTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.coverView);
    }];
    [self.titleTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverView).inset(8);
        make.left.mas_equalTo(self.coverView.mas_right).inset(17);
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
        make.right.mas_equalTo(self).inset(4);
        make.bottom.mas_equalTo(self).inset(8);
        make.height.mas_equalTo(30);
    }];
}

- (void)fetchLocation:(UIGestureRecognizer*)tap{
        //读取定位信息
    
    if (!CLLocationManager.locationServicesEnabled) {
            //定位不可用
        UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"定位功能不可用" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        [alertCtl addAction:ok];
        [self rootVCPresentViewController:alertCtl animated:YES completion:nil];
        
        return;
    }
    
    
        //跳转打开定位
    void(^openLocation)(void) = ^(){
        UIAlertController *alertVC = [[UIAlertController alloc] init];
        UIAlertAction *openLocatin = [UIAlertAction actionWithTitle:@"打开定位,可以获得更多关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] canOpenURL:url];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alertVC addAction:openLocatin];
        [alertVC addAction:cancel];
        [self rootVCPresentViewController:alertVC animated:YES completion:nil];
    };
    
        // location
    void(^location)(void) = ^(){
        CLLocationManager *manager = [[CLLocationManager alloc] init];
        [manager requestWhenInUseAuthorization];
        [manager setDelegate:self];
        [manager startUpdatingLocation];
        self->_manager = manager;
    };
    
    
    switch (CLLocationManager.authorizationStatus) {
            
        case kCLAuthorizationStatusDenied:{
            openLocation();
        }break;
            
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            location();
        }break;
            
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

#pragma mark - share action
- (void)shareToSina:(UIBarButtonItem*)send{
    
}
- (void)shareToQQ:(UIBarButtonItem*)send{
    
}
- (void)shareToWeChat:(UIBarButtonItem*)send{
    
}
- (void)shareToWeChatTimline:(UIBarButtonItem*)send{
    
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [manager stopUpdatingLocation];
    
        //
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    [geo reverseGeocodeLocation:locations.firstObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks.firstObject;
            //市
        NSString *locality = placemark.locality;
        NSString *sublocality = placemark.subLocality;
        
        NSString *loca = [NSString stringWithFormat:@"%@ - %@",locality,sublocality];
        [self.locationLab setText:loca];
    }];
}


@end
