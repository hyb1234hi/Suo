//
//  GALiveMessageView.m
//  Suo
//
//  Created by ysw on 2019/8/15.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveMessageView.h"
#import "GABaseTableViewCell.h"
#import "GALabel.h"
#import <YYKit.h>

@interface  _MessageCell : GABaseTableViewCell
@property(nonatomic,strong)GALabel *contentLabel;

@property(nonatomic,strong)UIColor *nameColor;
@property(nonatomic,strong)UIColor *contentColor;

@property(nonatomic,strong)NSDictionary *message;

@end

@interface GALiveMessageView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<NSDictionary*> *messae;

@end

@implementation GALiveMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:_MessageCell.class forCellReuseIdentifier:_MessageCell.identifier];
        [_tableView setBackgroundColor:UIColor.clearColor];
        [_tableView setEstimatedRowHeight:120];
        [_tableView setRowHeight:UITableViewAutomaticDimension];
        [_tableView setShowsVerticalScrollIndicator:NO];
        
        [self addSubview:_tableView];
        [self setBackgroundColor:UIColor.clearColor];
        
        _messae = @[@{@"name":@"send message test tableview"},
                    @{@"name":@"send message test tableview"},
                    @{@"name":@"send message test tableview"},
                    @{@"name":@"send message test tableview"},
                    ].mutableCopy;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tableView setFrame:self.bounds];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messae.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:_MessageCell.identifier forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.message = [self.messae objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)sendMessage:(NSDictionary *)message{
    
    [self.tableView beginUpdates];
    
    [self.messae addObject:message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messae.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath,] withRowAnimation:UITableViewRowAnimationBottom];
    
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
@end


@implementation _MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _contentColor = UIColor.whiteColor;
        _nameColor    = UIColor.blueColor;
        
        _contentLabel = GALabel.new;
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setBackgroundColor:ColorBlackAlpha40];
        [_contentLabel setTextInsets:UIEdgeInsetsMake(2, 4, 2, 4)];
        [_contentLabel.layer setCornerRadius:6];
        [_contentLabel.layer setMasksToBounds:YES];
        
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:_contentLabel];
        [self setBackgroundColor:UIColor.clearColor];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];

    [self.contentLabel setPreferredMaxLayoutWidth:CGRectGetWidth(self.bounds)-8];
    //[self.contentLabel setupMaskWithCorner:6.0 rectCorner:UIRectCornerAllCorners];  //不正确
}

- (void)setMessage:(NSDictionary *)message{

    _message = message;
    
    NSString *name = message.allKeys.firstObject;
    name = [NSString stringWithFormat:@"%@:  ",name];
    NSDictionary *nameAtt = @{NSForegroundColorAttributeName:_nameColor,
                              };
    
    NSString *content = message.allValues.firstObject;
    NSDictionary *contentAtt = @{NSForegroundColorAttributeName:_contentColor,
                                 };
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:name attributes:nameAtt];
    [att appendAttributedString:[[NSAttributedString alloc] initWithString:content attributes:contentAtt]];
    
    [self.contentLabel setAttributedText:att];
    
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(4, 4, 4, 4));
        make.right.mas_lessThanOrEqualTo(self.contentView);
    }];
    

    [self layoutIfNeeded];
   
}

@end
