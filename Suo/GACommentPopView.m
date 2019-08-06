//
//  GACommentPopView.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACommentPopView.h"
#import "GACommentCell.h"
#import "GACommentHeaderView.h"
#import "GACommentFooterView.h"
#import "GACommentDetailTableViewCell.h"

@interface GACommentPopView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,GACommentFooterViewDelegate>
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

/**
 section : 分组
 selected : 是否显示收回
 */
@property(nonatomic,strong) NSMutableArray *sectionArray; // 记录组尾拓展

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        //        [_tableView registerClass:GACommentCell.class forCellReuseIdentifier:GACommentCell.identifier];
        [_tableView setBackgroundColor:ColorClear];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        [_container addSubview:_tableView];
        [self.tableView registerClass:[GACommentHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([GACommentHeaderView class])];
        [self.tableView registerClass:[GACommentFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([GACommentFooterView class])];
        [self.tableView registerClass:GACommentDetailTableViewCell.class forCellReuseIdentifier:GACommentDetailTableViewCell.identifier];
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
    for (NSDictionary *obj in self.sectionArray) {
        NSInteger index = [[obj objectForKey:@"section"] integerValue];
        BOOL isSelected = [[obj objectForKey:@"selected"] boolValue];
        if (index == section) {
            if (isSelected) {
                return 3;
            }
    }
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    GACommentCell *cell = [tableView dequeueReusableCellWithIdentifier:GACommentCell.identifier forIndexPath:indexPath];
    //    cell.delegate = self;
    //    //[cell.textLabel setText:@"Could not signal service"];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    GACommentDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GACommentDetailTableViewCell.identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GACommentHeaderView *header = GACommentHeaderView.new;
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    GACommentFooterView *footer = GACommentFooterView.new;
    footer.delegate = self;
    footer.index = section;
    [self.sectionArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [[obj objectForKey:@"section"] integerValue];
        BOOL isSelected = [[obj objectForKey:@"selected"] boolValue];
        if (index == section) {
            footer.isSelected = isSelected;
        }
    }];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [@"内容回复" boundingRectWithSize:CGSizeMake(ScreenWidth - 91, MAXFLOAT) options:NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    height += 60;
    height -= 17;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 20;
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

#pragma mark ---- GACommentFooterViewDelegate
- (void)commentFooterViewWithSection:(NSInteger)section withSelection:(BOOL)isSelected {
    NSDictionary *dict = @{
                           @"section":@(section),
                           @"selected":@(isSelected)
                           };
    
    [self.sectionArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [[obj objectForKey:@"section"] integerValue];
        if (index == section) {
            [self.sectionArray removeObject:obj];
        }
    }];
    [self.sectionArray addObject:dict];
    [self.tableView reloadData];
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


#pragma mark ----  懒加载
- (NSMutableArray *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

@end
