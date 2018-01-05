//
//  ChooseGoodsViewController.m
//  DNFDemo
//
//  Created by ZhuJunyu on 2017/4/13.
//  Copyright © 2017年 ZhuJunyu. All rights reserved.
//

#import "ChooseGoodsViewController.h"
#import "GoodsModel.h"
#import "DBManger.h"
#import "DBManger+main.h"
#import "Masonry.h"
#import "MainViewController.h"
@interface ChooseGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}
@end

@implementation ChooseGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configArr];
    [self configTable];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!self.chooseBack) {
        self.navigationItem.title = @"价格记录";
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-UIHelper
- (void)configArr{
    _dataArr = [[NSMutableArray alloc]initWithArray:[DBManger getGoods]];
}
- (void)configTable{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.offset(0);
        make.top.offset(64);
        make.bottom.offset(-50);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    UILabel *priceLabel = [cell.contentView viewWithTag:1001];
    if (!priceLabel) {
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
        priceLabel.right =  cell.width -10;
        [cell.contentView addSubview:priceLabel];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.tag = 1001;
    }
    priceLabel.text = [NSString  moneyStringFormFloat:[_dataArr[indexPath.row] average]];
    cell.textLabel.text =  [_dataArr[indexPath.row] name];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.chooseBack) {
        self.chooseBack(_dataArr[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        MainViewController  *detailCtr = [MainViewController new];
        detailCtr.model = _dataArr[indexPath.row];
        [self pushController:detailCtr];
    }
}
- (void)pushController:(UIViewController *)ctr{
    UINavigationController *nav = (UINavigationController *)self.view.window.rootViewController;
    [nav pushViewController:ctr animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
