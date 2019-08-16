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

@property(nonatomic,strong)UILabel *textLengLabel;

@property(nonatomic,strong) UIToolbar *toolBar;
@property(nonatomic,strong) UIBarButtonItem *imageItem;
@property(nonatomic,strong) UIBarButtonItem *emojiItem;
@end

@implementation GACommentTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:ScreenBounds]) {
        [self setBackgroundColor:ColorBlackAlpha40];
        
        _textLength = 0;
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 160)];
        [_container setBackgroundColor:UIColor.whiteColor];
        
        _textView = [[UITextView alloc] init];
        [_textView setBackgroundColor:RGBA(240, 242, 244, 0.7)];
        [_textView.layer setCornerRadius:6];
        [_textView.layer setMasksToBounds:YES];
        [_textView setDelegate:self];
        [_textView setScrollEnabled:YES];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView sizeToFit];
        [_textView setFont:BigFont];
        [_textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        
        _textLengLabel = UILabel.new;
        [_textLengLabel setTextColor:UIColor.redColor];
        [_textLengLabel setHidden:YES];
        [_textLengLabel setFont:MainFontWithSize(14)];

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
        
    
        [_container addSubview:_textLengLabel];
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
        make.left.top.right.mas_equalTo(self.container).insets(UIEdgeInsetsMake(6, 16, 6, 50));
        make.bottom.mas_equalTo(self.toolBar.mas_top).inset(6);
    }];
    [_textLengLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView);
        make.left.mas_equalTo(self.textView.mas_right).inset(2);
        make.right.mas_equalTo(self.container).inset(2);
    }];
    
    [_toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.container);
        make.height.mas_equalTo(44);
    }];
    
    
}

- (void)setTextLength:(NSUInteger)textLength{
    
    [self.textLengLabel setHidden:textLength<=0];
    if (_textLength != textLength) {
        _textLength = textLength;
        [_textLengLabel setText:@(textLength).stringValue];
    }
}

#pragma mark - ========== textViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    int length = (int)(_textLength - textView.text.length);
    [_textLengLabel setText:@(length).stringValue];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (range.length > 0) {  //length == 删除  && text = @""
        return YES;
    }
    

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
    
    if (textView.text.length+text.length > _textLength && _textLength != 0 ) {
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
