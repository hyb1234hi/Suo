//
//  GAVideoPlayCell.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAVideoPlayCell.h"
#import "GAVideoPlayControllerView.h"


@interface GAVideoPlayCell ()

@property(nonatomic,strong) GAVideoPlayControllerView *controllerView;
@end

@implementation GAVideoPlayCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _controllerView = GAVideoPlayControllerView.new;
        
        [self.contentView addSubview:_controllerView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.controllerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0));
        make.height.mas_equalTo(280);
    }];
}

@end
