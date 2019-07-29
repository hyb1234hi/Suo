//
//  GACommentTextView.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACommentTextView.h"


@interface GACommentTextView ()<UITextViewDelegate>
@property(nonatomic,strong) UIView *container;

@property(nonatomic,assign) int  maxChart;

@property(nonatomic,strong) UIToolbar *toolBar;
@property(nonatomic,strong) UIBarButtonItem *imageItem;
@property(nonatomic,strong) UIBarButtonItem *emojiItem;
@end

@implementation GACommentTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:ScreenBounds]) {
        [self setBackgroundColor:ColorBlackAlpha40];
        
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 160)];
        [_container setBackgroundColor:UIColor.whiteColor];
        
        _textView = [[UITextView alloc] init];
        [_textView setBackgroundColor:RGBA(240, 242, 244, 0.7)];
        [_textView.layer setCornerRadius:6];
        [_textView.layer setMasksToBounds:YES];
        [_textView setDelegate:self];
        [_textView setScrollEnabled:NO];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView sizeToFit];
        [_textView setFont:BigFont];

        UIImage *image = [UIImage imageNamed:@"icon_home_like_after"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        _imageItem = [[UIBarButtonItem alloc] init];
        [_imageItem setImage:image];
        _emojiItem = [[UIBarButtonItem alloc] init];
        [_emojiItem setImage:image];
        _toolBar = [[UIToolbar alloc] init];
        
        UIBarButtonItem *fixbale = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [fixbale setWidth:20];
        
        [_imageItem setEnabled:NO];  //暂时无用
        [_emojiItem setEnabled:NO];  //暂时无用；
        [_toolBar setItems:@[_imageItem,fixbale,_emojiItem]];
        
        [_container addSubview:_textView];
        [_container addSubview:_toolBar];
        
        [self addSubview:_container];
        [_container setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        [_textView setInputAccessoryView:_container];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.container).insets(UIEdgeInsetsMake(6, 16, 6, 16));
        make.bottom.mas_equalTo(self.toolBar.mas_top).inset(6);
    }];
    [_toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.container);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark - ========== textViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
//    CGFloat newHeight = 170 ;// 计算新高度
//    NSLayoutConstraint *constraint = [[_container constraints] objectAtIndex:0];
//    constraint.constant = newHeight;
    
//    [textView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(textView.contentSize.height);
//    }];
    
//    CGFloat h = 12+44+ textView.contentSize.height;
//    CGRect frame = self.container.frame;
//    frame.size.height  = h ;
//    [self.container setFrame:frame];
//    NSLog(@"h --- %f",h);
//    //[self.textView.inputAccessoryView setFrame:frame];
//    [self.textView setInputAccessoryView:self.container];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        if (self.delegate) {
            [self.delegate sendComment:textView.text];
        }
        if (self.sendComment) {
            self.sendComment(textView.text);
        }
        [textView setText:@""];
        [textView resignFirstResponder];
    
        [self dismiss];
        return NO;
    }
    return YES;
}

- (void)show{
    UIView *window = [[UIApplication sharedApplication] delegate].window;
    [window addSubview:self];
    
    [self.textView setInputAccessoryView:self.container];
    [self.textView becomeFirstResponder];
    //[self.container setNeedsFocusUpdate];
   // [self.container updateFocusIfNeeded];
   
}
- (void)dismiss{
    [self.textView resignFirstResponder];
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
@end
