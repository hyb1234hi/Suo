//
//  GACommentCell.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACommentCell.h"


@interface GACommentCell ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView *avatarView; //!<评论用户头像
@property(nonatomic,strong)UILabel *userNameLab;    //!<评论用户
@property(nonatomic,strong)UILabel *contentLab;     //!<评论内容
@property(nonatomic,strong)UITableView *tableView;  //!<回复列表

@property(nonatomic,strong)UILabel *timeLab;        //!<时间信息

@property(nonatomic,strong)UIButton *lookAllRep;    //!<查看所有回复

@property (nonatomic, strong)NSMutableArray *dataSource;
@end

static CGFloat avatarH = 50;
static CGFloat avatarW = 50;

@implementation GACommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    
    _avatarView     = UIImageView.new;
    _userNameLab    = UILabel.new;
    _contentLab     = UILabel.new;
    _timeLab        = UILabel.new;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setBackgroundColor:ColorWhite];
    [_tableView setScrollEnabled:NO];
    [_tableView setRowHeight:40];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   // [_tableView setTableFooterView:self.lookAllRep];
    
    _lookAllRep = UIButton.new;
    [_lookAllRep setTitle:@"查看全部XX条回复 >" forState:UIControlStateNormal];
    [_lookAllRep setTitle:@"收起 <" forState:UIControlStateSelected];
    [_lookAllRep setTitleColor:RGBA(101, 101, 125, 1) forState:UIControlStateNormal];
    [_lookAllRep setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_lookAllRep setTitleEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];
    [_lookAllRep.titleLabel setFont:[MainFont fontWithSize:13]];
    [_lookAllRep addTarget:self action:@selector(lookAllRepClick:) forControlEvents:UIControlEventTouchUpInside];
    [_lookAllRep setFrame:CGRectMake(0, 0, 0, 15)];
    [_tableView setTableFooterView:_lookAllRep];
    
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_userNameLab];
    [self.contentView addSubview:_contentLab];
    [self.contentView addSubview:_tableView];
    [self.contentView addSubview:_timeLab];

    [_userNameLab setTextColor:ColorGray];
    [_userNameLab setFont:[MainFont fontWithSize:14]];
    
    [_contentLab setFont:[MainFont fontWithSize:15]];
    [_contentLab setNumberOfLines:2];
    
    [_timeLab setFont:[MainFont fontWithSize:12]];
    [_timeLab setTextColor:ColorGray];
    
    [_userNameLab setText:@"时代峰峻看"];
    [_contentLab setText:@"WebKit.NetworkingWebKit.Networking.WebKit.Networking.WebKit.Networking.WebKit.Networking"];
    [_timeLab setText:@"2019-08-00 17:30:00"];
    
    UIImage *image = [UIImage imageNamed:@"微信"];
    [_avatarView setImage:image];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(11, 16, 0, 0));
        make.size.mas_equalTo(CGSizeMake(avatarW,avatarH));
    }];
    [self.userNameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).inset(14);
        make.top.mas_equalTo(self.avatarView);
        //make.bottom.mas_equalTo(self.avatarView.mas_centerY).inset(2);
    }];
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLab);
        make.top.mas_equalTo(self.userNameLab.mas_bottom).inset(8);
        make.right.mas_equalTo(self.contentView).inset(16);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentLab);
        make.top.mas_equalTo(self.contentLab.mas_bottom).inset(11);
        make.height.mas_equalTo(70);
    }];
    
    [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentLab);
        //make.top.mas_equalTo(self.tableView.mas_bottom).inset(11);
        make.bottom.mas_equalTo(self.contentView).inset(8);
    }];
    
    
   // [_avatarView setupMaskWithCorner:avatarH/2.0 rectCorner:UIRectCornerAllCorners];
}

- (void)lookAllRepClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(commentCellShowMoreWithCell:withHeight:)]) {
        [self.delegate commentCellShowMoreWithCell:self withHeight:90.f];
    }
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(160);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.textLabel setText:@"MPMoviePlayerFirstVideoFrameRenderedNotification"];
    [cell.textLabel setFont:[MainFont fontWithSize:15]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}



- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
