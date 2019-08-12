//
//  GASelectedGoodsViewController.m
//  Suo
//
//  Created by ysw on 2019/8/12.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GASelectedGoodsViewController.h"
#import "GALiveGoodsTableCell.h"

#import "GAAPI.h"
#import "GALiveGoodsModel.h"
#import <UIImageView+WebCache.h>

@interface GASelectedGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIBarButtonItem *okItem;
@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)NSMutableArray<GALiveGoodsModel*> *goodsList;
@property(nonatomic,strong)NSMutableArray<GALiveGoodsModel*> *selectedArray;

@property(nonatomic,strong)UISearchController *searchController;

@end

@implementation GASelectedGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipe];
    
    [self.view setBackgroundColor:ColorWhite];
    self.selectedArray = @[].mutableCopy;
    
    
    [self.navigationItem setTitle:@"选择商品"];
//    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
//    [self.navigationItem setLargeTitleDisplayMode:UINavigationItemLargeTitleDisplayModeAlways];
  

    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    _okItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(okItemAction)];
    [_okItem setEnabled:NO];
    
    
    [self.navigationItem setLeftBarButtonItem:cancel];
    [self.navigationItem setRightBarButtonItem:_okItem];
    
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.searchBar];
 
    self.goodsList = @[].mutableCopy;
    [self reloadGoodsComletion:^(NSArray *array) {
        if (array.count > 0 ) {
            [self.tableView reloadData];
        }
        NSLog(@"array -- %@",array);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.goodsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GALiveGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:GALiveGoodsTableCell.identifier forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
    GALiveGoodsModel *goods = self.goodsList[indexPath.row];
    [cell setGoods:goods];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.okItem setEnabled:(tableView.indexPathsForSelectedRows>0)];
    [self.searchBar resignFirstResponder];
    
    [self.selectedArray addObject:self.goodsList[indexPath.row]];
    
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.okItem setEnabled:(tableView.indexPathsForSelectedRows>0)];
    [self.searchBar resignFirstResponder];
    [self.selectedArray removeObject:self.goodsList[indexPath.row]];
}


- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)okItemAction{
    if (self.selectedGoods) {
        self.selectedGoods(self.selectedArray);
    }
    [self dismiss];
}



#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView registerClass:GALiveGoodsTableCell.class forCellReuseIdentifier:GALiveGoodsTableCell.identifier];
        [_tableView setRowHeight:112];
        [_tableView setAllowsMultipleSelection:YES];
        [_tableView setTableFooterView:UIView.new];
    }
    return _tableView;
}
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    }
    return _searchBar;
}


#pragma mark - loadData
- (void)reloadGoodsComletion:(void(^)(NSArray*dataArray))completin{
    [self fetchDataWithPage:1 term:@"" comletion:^(NSDictionary *json, NSURLResponse *response) {
        //NSLog(@"json -- %@",json);
        self.goodsList = [self serializationJSONToModel:json];
        if (completin) {
             completin(self.goodsList);
        }
        
       
    }];
}
- (void)loadNextPage:(int)page completion:(void(^)(NSArray*))comletion{
    
}

- (void)fetchDataWithPage:(int)page term:(NSString*)goodsKeyWorld comletion:(void(^)(NSDictionary*json,NSURLResponse*response))completion{
    [GAAPI.new.videoAPI fetchLiveGoodsForKey:self.loginKey withGoodsKey:nil page:page size:0 completion:completion];
}
- (NSMutableArray*)serializationJSONToModel:(NSDictionary*)json{
    NSMutableArray *array = @[].mutableCopy;
    if ([json valueForKeyPath:@"datas.data"]) {
        NSArray *tmp = [json valueForKeyPath:@"datas.data"];
        for (NSDictionary *dict  in tmp) {
            [array addObject:[GALiveGoodsModel instanceWithDict:dict]];
        }
    }
    
    return array;
}
@end
