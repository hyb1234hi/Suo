//
//  GALiveWatchControllerView.m
//  Suo
//
//  Created by ysw on 2019/7/29.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveWatchControllerView.h"

#import <BarrageRenderer.h>


@interface GALiveWatchControllerView ()<BarrageRendererDelegate>

@property(nonatomic,strong)BarrageRenderer *renderer;
@end

@implementation GALiveWatchControllerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self initRenderer];
        
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
}

- (void)setupUI{
    [self setBackgroundColor:UIColor.clearColor];
    
    
    
}

@end
