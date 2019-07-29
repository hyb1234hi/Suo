//
//  GACommentPopView.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACommentPopView.h"
#import "GACommentCell.h"


@interface GACommentPopView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
//@property(nonatomic,strong) BaseItem *item;
//@property(nonatomic,strong) NSArray<CommentModel*> *commentList;

@property(nonatomic,strong) UIView *container;
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) UITextView *textView;

@property(nonatomic,strong) UIView *tipView;
@property(nonatomic,strong) UIView *lineView;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *close;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation GACommentPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self loadComment];
        
        [self setFrame:ScreenBounds];
        [self setBackgroundColor:ColorBlackAlpha20];
    }
    return self;
}

- (void)setupUI{
        //容器
    ({
        _container = [UIView  new];
        [_container setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight*(3/4.0))];
        [_container setBackgroundColor:RGBA(248, 248, 248, 1)];
        [self addSubview:_container];
        
        UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
        UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:_container.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(10,10)];
        CAShapeLayer *shape = [[CAShapeLayer alloc] init];
        [shape setPath:round.CGPath];
        [_container.layer setMask:shape];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        
        [effectView setFrame:ScreenBounds];
        [_container addSubview:effectView];
    });
    
        //顶部tip coloe
    ({
        _tipView = [UIView new];
        _titleLabel = [UILabel new];
        _close = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评论关闭icon"]];
        
        _lineView = UIView.new;
        [_lineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [_tipView addSubview:_lineView];
        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.tipView);
            make.height.mas_equalTo(1);
        }];
        
        [_titleLabel setFont:[MainFont fontWithSize:18]];
        [_titleLabel setTextColor:ColorBlack];
        [_titleLabel setText:@"1023条评论"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_close addGestureRecognizer:tap];
        
        [_tipView addSubview:_titleLabel];
        [_tipView addSubview:_close];
        [_container addSubview:_tipView];
        
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.tipView).inset(16);
            make.centerY.mas_equalTo(self.tipView);
        }];
        [_close mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.tipView);
            make.right.mas_equalTo(self.tipView).inset(20);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
    });
    
        //中间tableVew
    ({
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:GACommentCell.class forCellReuseIdentifier:GACommentCell.identifier];
        [_tableView setTableFooterView:UIView.new];
        [_tableView setBackgroundColor:ColorClear];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];

        
        [_container addSubview:_tableView];
    });
    
        //低部评论
    ({
        _textField = [[UITextField alloc] init];
        [_textField setDelegate:self];
        NSAttributedString *att = [[NSAttributedString alloc] initWithString:@"   写评论..." attributes:@{NSForegroundColorAttributeName:ColorWhite}];
        [_textField setAttributedPlaceholder:att];
        [_textField setBackgroundColor:ColorGray];
        [_textField.layer setCornerRadius:18];
        [_textField.layer setMasksToBounds:YES];
        
        
        [_container addSubview:_textField];
    });
}

- (void)loadComment{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.tipView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.container);
        make.height.mas_equalTo(40.0f);
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.container).insets(UIEdgeInsetsMake(0, 20, SafeAreaBottomHeight+10, 20));
        make.height.mas_equalTo(36.0f);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.container);
        make.top.mas_equalTo(self.tipView.mas_bottom);
        make.bottom.mas_equalTo(self.textField.mas_top).inset(8);
    }];
    
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 80, 0, 0)];
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
//    [UIView animateWithDuration:0.15f
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         CGRect frame = self.container.frame;
//                         frame.origin.y = frame.origin.y - frame.size.height;
//                         self.container.frame = frame;
//                     }
//                     completion:^(BOOL finished) {
//                     }];
//
    CGRect frame = self.container.frame;
    frame.origin.y = frame.origin.y - frame.size.height;
    [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.container.frame = frame;
    } completion:^(BOOL finished) {}];
    
   // [self.textView show];
}
- (void)dismiss {
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         //[self.textView dismiss];
                     }];
}

#pragma mark - UITableViewdataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GACommentCell *cell = [tableView dequeueReusableCellWithIdentifier:GACommentCell.identifier forIndexPath:indexPath];
    //[cell.textLabel setText:@"Could not signal service"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

#pragma mark - ======== UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // CheckUserLogin;
//
//    CommentTextView *textView = [CommentTextView new];
//    __weak typeof(self) wself = self;
//    [textView setSendComment:^(NSString * _Nonnull text) {
//        LCSendComment*comment = [LCSendComment new];
//        comment.identifier = wself.item.identifier;
//        comment.authkey = wself.currentUser.authkey;
//        comment.content = text;
//        comment.comment_id = [wself.commentList objectAtIndex:indexPath.row].identifier ;
//        [LCDataStore.new sendComment:comment competion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
//            BOOL r = [[json valueForKey:@"r"] boolValue];
//            NSString *title = r ? @"评论成功" : @"评论失败";
//            [wself showHUDToView:wself withMessage:title];
//            [wself loadComment];
//        }];
//    }];
//    [textView show];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if (!self.currentUser) {
//        [self showLoginViewController];
//        return NO;
//    }
//
//    CommentTextView *textView = [CommentTextView new];
//    [textView setDelegate:self];
//    [textView show];
    return NO;
}

#pragma mark - SendCommentProtocol
-(void)sendComment:(NSString *)text{
//    LCSendComment *comment = [LCSendComment new];
//    comment.identifier = self.item.identifier;
//    comment.authkey = self.currentUser.authkey;
//    comment.content = text;
//    
//    [LCDataStore.new sendComment:comment competion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
//        BOOL r = [[json valueForKey:@"r"] boolValue];
//        NSString *title = r ? @"评论成功" : @"评论失败";
//        [self showHUDToView:self withMessage:title];
//        [self loadComment];
//    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
@end
