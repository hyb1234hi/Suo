//
//  GALiveWatchControllerView.m
//  Suo
//
//  Created by ysw on 2019/7/29.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveWatchControllerView.h"
#import "MLEmojiLabel+BarrageView.h"

#import <BarrageRenderer.h>


@interface GALiveWatchControllerView ()<BarrageRendererDelegate>

@property(nonatomic,strong)BarrageRenderer *renderer;
@property(nonatomic,strong)NSTimer *timer;


@property(nonatomic,assign)NSInteger index;

@end

@implementation GALiveWatchControllerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self initRenderer];
        _index = 0;
    }
    return self;
}

- (void)initRenderer{
    _renderer = [[BarrageRenderer alloc] init];
    [_renderer setDelegate:self];
    [_renderer setSmoothness:0.8];

    [_renderer.view setUserInteractionEnabled:YES];
    [self addSubview:_renderer.view];
    [self sendSubviewToBack:_renderer.view];
    
    [_renderer start];
    [self startBarrageMessage];
}

- (void)setupUI{
    [self setBackgroundColor:UIColor.clearColor];
    
}

- (void)startBarrageMessage{
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(autoSendBarrage) userInfo:nil repeats:YES];
    [_timer fire];
    
}
- (void)autoSendBarrage
{
    NSInteger spriteNumber = [_renderer spritesNumberWithName:nil];
   // self.infoLabel.text = [NSString stringWithFormat:@"当前屏幕弹幕数量: %ld",(long)spriteNumber];
    if (spriteNumber <= 500) { // 用来演示限制屏幕上的弹幕量

        
        [_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideLeft]];
        //[_renderer receive:[self floatTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideLeft]];
        //[_renderer receive:[self walkTextSpriteDescriptorWithDirection:BarrageWalkDirectionB2T side:BarrageWalkSideLeft]];
    }
}

//- (BarrageDescriptor *)flowerImageSpriteDescriptor
//{
//    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
//    descriptor.spriteName = NSStringFromClass([FlowerBarrageSprite class]);
//    descriptor.params[@"image"] = [[UIImage imageNamed:@"avatar"]barrageImageScaleToSize:CGSizeMake(40.0f, 40.0f)];
//    descriptor.params[@"duration"] = @(10);
//    descriptor.params[@"viewClassName"] = NSStringFromClass([UILabel class]);
//    descriptor.params[@"text"] = @"^*-*^";
//    descriptor.params[@"borderWidth"] = @(1);
//    descriptor.params[@"borderColor"] = [UIColor grayColor];
//    descriptor.params[@"scaleRatio"] = @(4);
//    descriptor.params[@"rotateRatio"] = @(100);
//    return descriptor;
//}

    /// 生成精灵描述 - 过场文字弹幕
- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(BarrageWalkDirection)direction
{
    return [self walkTextSpriteDescriptorWithDirection:direction side:BarrageWalkSideDefault];
}

    /// 生成精灵描述 - 过场文字弹幕
- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(BarrageWalkDirection)direction side:(BarrageWalkSide)side
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];

    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    descriptor.params[@"bizMsgId"] = [NSString stringWithFormat:@"%ld",(long)_index];
    descriptor.params[@"text"] = [NSString stringWithFormat:@"过场🥰文字弹幕:%ld",(long)_index++];
    descriptor.params[@"textColor"] = [UIColor blueColor];
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


    /// 生成精灵描述 - 浮动文字弹幕
- (BarrageDescriptor *)floatTextSpriteDescriptorWithDirection:(NSInteger)direction side:(BarrageFloatSide)side
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = NSStringFromClass([BarrageFloatTextSprite class]);
    descriptor.params[@"text"] = [NSString stringWithFormat:@"AA-图文混排/::B过场弹幕:%ld",(long)_index++];
    descriptor.params[@"viewClassName"] = @"MLEmojiLabel";
    descriptor.params[@"textColor"] = [UIColor purpleColor];
    descriptor.params[@"duration"] = @(3);
    //descriptor.params[@"fadeInTime"] = @(1);
    descriptor.params[@"fadeOutTime"] = @(1);
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"side"] = @(side);
    return descriptor;
}

@end
