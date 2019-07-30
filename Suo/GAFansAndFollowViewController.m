//
//  GAFansAndFollowViewController.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAFansAndFollowViewController.h"
#import "GAAuthorViewController.h"
#import "GAFansFollowCell.h"



@interface GAFansAndFollowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign) ViewControllerType type;
@end

@implementation GAFansAndFollowViewController

- (instancetype)initWithType:(ViewControllerType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (_type) {
            case ViewControllerTypeFollow:{
                [self setTitle:@"关注"];
            }break;
            
            case ViewControllerTypeFans:{
                [self setTitle:@"粉丝"];
            }break;
    }
    
    [self.view addSubview:self.tableView];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GAFansFollowCell *cell = (GAFansFollowCell*)[tableView dequeueReusableCellWithIdentifier:GAFansFollowCell.identifier forIndexPath:indexPath];
    
    [cell.textLabel setText:@"你的头卡住了🤪"];
    [cell.imageView setImage:[UIImage imageNamed:@"icon_home_like_after"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GAAuthorViewController *vc = [[GAAuthorViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        [_tableView registerClass:GAFansFollowCell.class forCellReuseIdentifier:GAFansFollowCell.identifier];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setRowHeight:60];
        
    }
    return _tableView;
}


@end
