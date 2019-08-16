//
//  GALiveBroadcastControlView.m
//  Suo
//
//  Created by ysw on 2019/8/2.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveBroadcastControlView.h"
#import "GACommentTextView.h"
#import "GAGoodsPushSelectView.h"
#import "GABeautyFilterView.h"

#import "GABeautyFilterView.h"
#import "GALiveMessageView.h"

#import <BarrageRenderer.h>
#import <SocketRocket.h>
#import <YYKit.h>
#import <CoreServices/CoreServices.h>


@interface GALiveBroadcastControlView ()<BarrageRendererDelegate,SRWebSocketDelegate>

@property(nonatomic,strong)UIButton *stopLiveBtn;   //!<退出直播
@property(nonatomic,strong)UIButton *sendMSG;       //!<发送消息
@property(nonatomic,strong)UIButton *pushGoods;     //推送商品
@property(nonatomic,strong)UIButton *beautyBtn;     //!<美颜按钮

@property(nonatomic,strong)GABeautyFilterView *beautyView;  //!<美颜视图
@property(nonatomic,strong)BarrageRenderer *renderer;       //!<弹幕渲染
@property(nonatomic,strong)GALiveMessageView *messageView;


@property(nonatomic,strong)SRWebSocket *socket;


@end

@implementation GALiveBroadcastControlView

- (void)dealloc{
    [_socket close];
    _socket = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserverBlocks];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _renderer       = [[BarrageRenderer alloc] init];
    _beautyView     = [[GABeautyFilterView alloc] init];
    _messageView    = [[GALiveMessageView alloc] init];

    _stopLiveBtn    = UIButton.new;
    _beautyBtn      = UIButton.new;
    _sendMSG        = UIButton.new;
    _pushGoods      = UIButton.new;
    
    
    [self addSubview:_renderer.view];
    [self sendSubviewToBack:_renderer.view];
    [self addSubview:_stopLiveBtn];
    [self addSubview:_beautyBtn];
    [self addSubview:_beautyView];
    [self addSubview:_sendMSG];
    [self addSubview:_pushGoods];
    [self addSubview:_messageView];
    
    [_renderer setDelegate:self];
    [_renderer setSmoothness:0.8];
    [_renderer setSpeed:0.000000001];
    [_renderer setCanvasMargin:UIEdgeInsetsMake(ScreenHeight/2.0, 10, self.safeAreaInsets.bottom+20, 10)];
    [_renderer.view setUserInteractionEnabled:YES];
    [_renderer start];
    
    
    [_stopLiveBtn setTitle:@"退出直播" forState:UIControlStateNormal];
    [_stopLiveBtn setBackgroundColor:ColorBlackAlpha20];
    
    [_beautyBtn setTitle:@"🤯" forState:UIControlStateNormal];
    [_beautyBtn.layer setCornerRadius:15];
    [_beautyBtn.layer setMasksToBounds:YES];
    [_beautyBtn setBackgroundColor:ColorBlackAlpha20];
    
    
    [_sendMSG setTitle:@"发弹幕" forState:UIControlStateNormal];
    [_pushGoods setTitle:@"推商品" forState:UIControlStateNormal];
    
    [self beautyViewHiddenLayout];

    UIControlEvents events = UIControlEventTouchUpInside;
    [_sendMSG addTarget:self action:@selector(onSendMSG:) forControlEvents:events];
    [_pushGoods addTarget:self action:@selector(onPushGoods:) forControlEvents:events];
    [_beautyBtn addTarget:self action:@selector(onButtonAction:) forControlEvents:events];
    [_stopLiveBtn addTarget:self action:@selector(onButtonAction:) forControlEvents:events];
    
    
    
    __weak typeof(self) wself = self;
    void(^normalLayout)(void) = ^{
        [wself.messageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(wself).insets(UIEdgeInsetsMake(6, 0, 0, 6));
            make.bottom.mas_equalTo(wself.sendMSG.mas_top).inset(4);
            make.height.mas_equalTo(180);
        }];
    };
    normalLayout();
    
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        CGRect frame = [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat bottomOffset = CGRectGetHeight(frame);
        [wself.messageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(wself).insets(UIEdgeInsetsMake(6, 0, 0, 6));
            make.bottom.mas_equalTo(wself).inset(bottomOffset-(wself.safeAreaInsets.bottom));
            make.height.mas_equalTo(180);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [wself layoutIfNeeded];
        }];
    }];
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        normalLayout();
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.sendMSG mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 16, 16, 0));
    }];
    [self.pushGoods mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sendMSG.mas_right).inset(16);
        make.bottom.mas_equalTo(self.sendMSG);
    }];
    
    [self.stopLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.sendMSG);
        make.right.mas_equalTo(self).inset(16);
    }];


    [self.beautyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).insets(UIEdgeInsetsMake(11, 16, 0, 0));
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self beautyViewHiddenLayout];
}

- (void)beautyViewHiddenLayout{
    [_beautyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-32.0, (ScreenWidth-32)*((140/375.0)+(44/375.0))));
        make.right.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.beautyBtn.mas_bottom).inset(8);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}
- (void)beautyViewShowLayout{
    [_beautyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 16, 0, 16));
        make.top.mas_equalTo(self.beautyBtn.mas_bottom).inset(8);
        make.height.mas_equalTo(self.beautyView.mas_width).multipliedBy((140/375.0)+(44/375.0));
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}


#pragma mark - setter /getter
- (void)setParams:(GABeautyFilterParams *)params{
    if (_params != params) {
        _params = params;
        [_beautyView setParams:params];
    }
}
-(void)setPusher:(AlivcLivePusher *)pusher{
    if (_pusher != pusher) {
        _pusher = pusher;
        [_beautyView setPusher:pusher];
        if ([pusher isPushing]) {
            
        }
    }
}



#pragma mark - SRWebSocketDelegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"接收 >>>>>>>>>>>>>>>>>> %@",message);
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    if ([[dict valueForKey:@"type"] isEqualToString:@"connect"]) {
        
        NSString *msg = [dict valueForKeyPath:@"data.msg"];
        NSString *name = [dict valueForKey:@"uname"];
        [self.messageView sendMessage:@{name:msg}];
    }
    

    //[self.renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideDefault msg:msg]];
    
    
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"弹幕连接错误 ---->%@",error);
}

-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    //NSLog(@"------------->>>>>>弹幕连接成功");
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.liveMode.danmu.json options:NSJSONWritingSortedKeys error:nil];
    [self.socket send:data];
}

- (void)setLiveMode:(GAOpenLiveModel *)liveMode{
    if (_liveMode != liveMode) {
        _liveMode = liveMode;
        
        NSString *api = Barrage_URL;
        NSMutableURLRequest *request =  [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:api]];
        
        _socket = [[SRWebSocket alloc] initWithURLRequest:request];
        [_socket setDelegate:self];
        [_socket open];
    }
}




#pragma mark - 弹幕处理
- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(BarrageWalkDirection)direction
                                                        side:(BarrageWalkSide)side
                                                         msg:(NSString*)msg {
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    
    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    //descriptor.params[@"bizMsgId"] = [NSString stringWithFormat:@"%ld",(long)_index];
    //descriptor.params[@"text"] = [NSString stringWithFormat:@"过场🥰文字弹幕:%ld",(long)_index++];
    descriptor.params[@"text"] = msg;
//    descriptor.params[@"viewClassName"] = NSStringFromClass([UILabel class]);
//    descriptor.params[@"numberOfLines"] = 0;
    //descriptor.params[@"attributedText"] = NSAttributedString;
    descriptor.params[@"textColor"] = [UIColor whiteColor];
    descriptor.params[@"speed"] = @(100);
        //descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX+50);
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"duration"] = @(3);
    descriptor.params[@"fadeOutTime"] = @(2.2);  //淡出
    descriptor.params[@"side"] = @(side);
    descriptor.params[@"clickAction"] = ^(NSDictionary *params){
        NSString *msg = [NSString stringWithFormat:@"弹幕 %@ 被点击",params[@"bizMsgId"]];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
    };
    return descriptor;
}


#pragma mark - Button Action

- (void)onPushGoods:(UIButton*)send{
    [GAGoodsPushSelectView.new show];
}
- (void)onSendMSG:(UIButton*)send{
    GACommentTextView *text = GACommentTextView.new;
    [text setBackgroundColor:UIColor.clearColor];
    [text setTextLength:120];
    
    CGRect frame = text.frame;
    frame.size.height -= 40;
    [text setFrame:frame];
    
    [text setSendComment:^(NSString * _Nonnull text) {
        BarrageDescriptor *desc = [self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideDefault  msg:text];
        
        [self.socket send:text];
        [self.renderer receive:desc];
        
        [UIView animateWithDuration:0.25 animations:^{
            
        } completion:^(BOOL finished) {
             [self.messageView sendMessage:@{@"send sss > ":text}];
        }];
    }];
    [text show];
}

- (void)onButtonAction:(UIButton*)send{
    if (send == self.stopLiveBtn) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定结束直播？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendMSGToDelegateWithSel:@selector(stopLive)];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self rootVCPresentViewController:alert animated:YES completion:nil];
    }
    
    if (send == self.beautyBtn) {
        [self beautyViewShowLayout];
    }
    
}

//发送消息到代理
- (void)sendMSGToDelegateWithSel:(SEL)sel{
    if ([self.delegate respondsToSelector:sel]) {
        [self.delegate performSelector:sel];
    }
}

@end
