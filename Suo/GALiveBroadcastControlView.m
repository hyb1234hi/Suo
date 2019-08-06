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
        NSString *uid = @"14";
        NSString *roomID = @"10004";
        NSString *ltoken = @"122317461#$&*@hbdjbcaysg*())*&^%23131231";
        NSString *ntime = @"";
        
        NSDate *date = [NSDate date];
        NSTimeInterval interval = [date timeIntervalSince1970];
        int t = (int)interval;
        ntime = @(t).stringValue;
        
        
        NSString *token = [NSString stringWithFormat:@"%@%@%@%@",uid,roomID,ltoken,ntime];
        token  = [token md5String];
        
        NSDictionary *para = @{@"type":@"connect",
                               @"uid":uid,
                               @"uname":@"ios_test2",
                               @"room_id":roomID,
                               @"ntime":@(t).stringValue,
                               @"ltoken":token,
                               @"other_data":@""
                               };
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:nil];
        _data = data;
        
        NSString *api = @"ws://192.168.1.11:2000";
        NSMutableURLRequest *request =  [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:api]];
        
        _socket = [[SRWebSocket alloc] initWithURLRequest:request];
        [_socket setDelegate:self];
        [_socket open];
    
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
    NSLog(@"message --->>>>>>>>>>>>>>>>>>>>>>>>>>> %@",message);
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSString *b = [dict valueForKeyPath:@"data.msg"];
    
    [self.renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideDefault msg:b]];
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"error ---- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@",error);
}

-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"------------->>>>>>>>>>>>>>>>>>>>>>>>>>>连接成功");
    [self.socket send:self.data];
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

// 默认 POST
- (NSURLRequest *)createRequestWithPath:(NSString*)path parameter:(NSDictionary*)params method:(NSString*)method{
    
        // NSLog(@"dict --- %@",params);
    if ([method isEqualToString:@"GET"]) {
        __block NSString *api = path;
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *str = [NSString stringWithFormat:@"&%@=%@",key,obj];
            api = [api stringByAppendingString:str];
        }];
        
            //转码字符集
        NSCharacterSet *charSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        api = [api stringByAddingPercentEncodingWithAllowedCharacters:charSet];
        
        NSURL *url = [NSURL URLWithString:api];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:30.0];
        return request;
        
    }else{
            //post
        NSString *api = path;
        NSURL *url = [NSURL URLWithString:api];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:30.0];
        
        NSString *boundary = [self generateBoundaryString];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        
        NSData *fromData = [self createBodyWithBoundary:boundary parameters:params paths:nil fieldName:nil];
        [request setHTTPBody:fromData];
        
        NSString *length = [NSString stringWithFormat:@"%lu",fromData.length];
        [request setValue:length forHTTPHeaderField:@"Content-Length"];
        return request;
    }
    
}

- (NSString*)generateBoundaryString{
    return  [NSString stringWithFormat:@"--Boundary-%@",[NSUUID new].UUIDString];
}

- (NSData*)createBodyWithBoundary:(NSString*)boundary parameters:(NSDictionary*)parameters paths:(NSArray*)paths fieldName:(NSString*)fieldName{
    
    NSMutableData *httpBody = [NSMutableData data];
        // add params (all params are strings)
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, id parameterValue, BOOL *stop) {
        
            //NSLog(@"  value ===%@",parameterValue);
        if ([parameterValue  isKindOfClass:NSArray.class]) {
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            for (NSString *imageName in parameterValue) {
                [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", imageName] dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }else{
            [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }];
    
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return httpBody;
}

- (NSString *)mimeTypeForPath:(NSString *)path {
        // get a mime type for an extension using MobileCoreServices.framework
    
    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);
    
    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);
    
    CFRelease(UTI);
    
    return mimetype;
}

@end
