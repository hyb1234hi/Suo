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

#import <BarrageRenderer.h>
#import <SocketRocket.h>
#import <YYKit.h>
#import <CoreServices/CoreServices.h>


@interface GALiveBroadcastControlView ()<BarrageRendererDelegate,SRWebSocketDelegate>
@property(nonatomic,strong)UIButton *stopLiveBtn;   //!<退出直播
@property(nonatomic,strong)UIButton *sendMSGBtn;    //!<发送消息
@property(nonatomic,strong)UIButton *sendPrivateMSGBtn; //!<发送私信

@property(nonatomic,strong)BarrageRenderer *renderer;   //!<弹幕渲染

// bottom
@property(nonatomic,strong)UIButton *sendMSG;
@property(nonatomic,strong)UIButton *pushGoods;
@property(nonatomic,strong)UIButton *pullMSG;

@property(nonatomic,strong)SRWebSocket *socket;
@property(nonatomic,strong)NSData *data;

@end

@implementation GALiveBroadcastControlView

- (void)dealloc{
    [_socket close];
    _socket = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _renderer = [[BarrageRenderer alloc] init];
    [_renderer setDelegate:self];
    [_renderer setSmoothness:0.8];
    [_renderer setCanvasMargin:UIEdgeInsetsMake(0, 8, 8, 8)];
    [_renderer.view setUserInteractionEnabled:YES];
    [self addSubview:_renderer.view];
    [self sendSubviewToBack:_renderer.view];
    [_renderer start];
    
    _stopLiveBtn = UIButton.new;
    [_stopLiveBtn addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_stopLiveBtn setTitle:@"退出直播" forState:UIControlStateNormal];
    
    [self addSubview:_stopLiveBtn];
    
    //bottom
    ({
        _sendMSG = UIButton.new;
        _pushGoods = UIButton.new;
        _pullMSG = UIButton.new;
        
        [_sendMSG setTitle:@"发弹幕" forState:UIControlStateNormal];
        [_pushGoods setTitle:@"推商品" forState:UIControlStateNormal];
        [_pullMSG setTitle:@"私信消息" forState:UIControlStateNormal];
        
        [self addSubview:_sendMSG];
        [self addSubview:_pushGoods];
        [self addSubview:_pullMSG];
        
        [_sendMSG addTarget:self action:@selector(onSendMSG:) forControlEvents:UIControlEventTouchUpInside];
        [_pushGoods addTarget:self action:@selector(onPushGoods:) forControlEvents:UIControlEventTouchUpInside];
    });
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.stopLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 8, 16));
    }];
    
    [self.sendMSG mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 16, 16, 0));
    }];
    [self.pushGoods mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sendMSG.mas_right).inset(16);
        make.bottom.mas_equalTo(self.sendMSG);
    }];
    [self.pullMSG mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pushGoods.mas_right).inset(16);
        make.bottom.mas_equalTo(self.pushGoods);
    }];

}


#pragma mark - SRWebSocketDelegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"接收 >>>>>>>>>>>>>>>>>> %@",message);
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSString *b = [dict valueForKeyPath:@"data.msg"];
    
    [self.renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideDefault msg:b]];
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"弹幕连接错误 ---->%@",error);
}

-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"------------->>>>>>弹幕连接成功");
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.liveMode.danmu_connect_data.json options:NSJSONWritingSortedKeys error:nil];
    [self.socket send:data];
}

- (void)setLiveMode:(GAOpenLiveModel *)liveMode{
    if (_liveMode != liveMode) {
        _liveMode = liveMode;
        
        NSString *api = @"ws://192.168.1.11:2000";
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
    [text setSendComment:^(NSString * _Nonnull text) {
        BarrageDescriptor *desc = [self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideDefault  msg:text];
        
        [self.socket send:text];
        [self.renderer receive:desc];
    }];
    [text show];
}

- (void)onButtonAction:(UIButton*)send{
    if (send == self.stopLiveBtn) {
        [self sendMSGToDelegateWithSel:@selector(stopLive)];
    }
}

//发送消息到代理
- (void)sendMSGToDelegateWithSel:(SEL)sel{
    if ([self.delegate respondsToSelector:sel]) {
        [self.delegate performSelector:sel];
    }
}

@end
