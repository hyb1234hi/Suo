//
//  GATalkingHeader.m
//  Suo
//
//  Created by gajz on 2019/8/5.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GATalkingHeader.h"

@interface GATalkingHeader()

/**time**/
@property (nonatomic, strong)UILabel *time;

@end

@implementation GATalkingHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    _time = UILabel.new;
    _time.font = [MainFont fontWithSize:14];
    _time.textColor = UIColorFromRGB(0xb0b0b0);
    _time.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_time];
}

- (void)setTimeString:(NSString *)timeString {
    _timeString = timeString;
    self.time.text = timeString;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.time mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
}

@end
