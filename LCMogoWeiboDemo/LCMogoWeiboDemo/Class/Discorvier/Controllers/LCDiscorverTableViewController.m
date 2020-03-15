//
//  LCDiscorverTableViewController.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCDiscorverTableViewController.h"
#import "TestViewController.h"
#import "NewTopModel.h"
#import "LCRequestManager.h"
#import "NewDataModel.h"
@interface LCDiscorverTableViewController ()<TestVcDeletate, LCRequestManagerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) LCRequsestBase *req;

@property (nonatomic, strong) LCRequestManager *reqManager;

@property (nonatomic, strong) NewDataModel *dataM;

@property (nonatomic, strong) NSMutableArray *dataA;



@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LCDiscorverTableViewController
- (LCRequestManager *)reqManager{
    if (!_reqManager) {
        _reqManager = [[LCRequestManager alloc]init];
        _reqManager.delegate = self;
    }
    return _reqManager;
}
- (LCRequsestBase *)req{
    if (!_req) {
        _req = [[LCRequsestBase alloc]init];
        _req.UrlString = @"http://zhouxunwang.cn/data/";
        //新闻
//        [_req.params setDictionary:@{@"id":@"75",
//                                    @"key":@"AeCU/NQzQtv+ip2I8Y0zRWvAMwTgsJeZ/px16A",
//                                    @"type":@"top"
//                                    }];
        //笑话
        NSTimeInterval time = [[[NSDate alloc]init] timeIntervalSince1970];

        NSString *timesStr = [NSString stringWithFormat:@"%10.f",time];

        [_req.params setDictionary:@{@"id":@"34",
                                    @"key":@"V7nGr4BlH9j+ip2I8Y0zRWvAMwTgsJeZ/pxx6Q",
                                    @"sort":@"decs",
                                     @"time":timesStr
                                    }];
    }
    return _req;
}
- (NSMutableArray *)dataA{
    if (!_dataA) {
        _dataA = [[NSMutableArray alloc]init];
    }
    return _dataA;
}


- (UITableView *)tableView{
    if (!_tableView) {
         _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 40;
        _tableView.rowHeight =UITableViewAutomaticDimension;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LCRandomColor;
    [self.view addSubview:self.tableView];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"delegate" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    // Do any additional setup after loading the view.
    
    [self.reqManager startRequest:self.req withView:self.view];
    __weak  typeof(self) weakSelf = self;
    [self.tableView addRefreshHeader:^{
        [weakSelf.reqManager startRequest:weakSelf.req withView:nil];
    }];
    LCButton *button2 = [[LCButton alloc]initWithFrame:CGRectMake(100, 220, 100, 100)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"block" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button2];
    [button2 addAction:^(LCButton *button) {
        
        TestViewController *testVc = [[TestViewController alloc]init];
        testVc.popBlock = ^(UIColor * _Nonnull color) {
            self.navigationItem.title = @"Block";
        };
        [weakSelf.navigationController pushViewController:testVc animated:YES];
    }];
}

- (void)pressButton{
    TestViewController *testVc = [[TestViewController alloc]init];
    testVc.delegate = self;
    testVc.popBlock = ^(UIColor * _Nonnull color) {
        self.view.backgroundColor = color;
    };
    [self.navigationController pushViewController:testVc animated:YES];
}

- (void)popVc:(UIColor *)color{
    self.navigationItem.title = @"Delegate";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requestFailure:(LCResponse *)response {
    NSDictionary *responseDic = (NSDictionary *)response.responseObject;
    LCLogVerbose(@"%@",responseDic);
    
}

- (void)requestSuccess:(LCResponse *)response {
    NSDictionary *responseDic = (NSDictionary *)response.responseObject;
    LCLogVerbose(@"%@",responseDic);
    NewTopModel *model = [NewTopModel mj_objectWithKeyValues:responseDic];
    [self.dataA addObjectsFromArray:model.result.data];
    [self.tableView reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell_id"];

    }
    
    NewDataModel *model = [self.dataA objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = model.content;
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TestViewController *testVc = [[TestViewController alloc]init];
    [self.navigationController pushViewController:testVc animated:YES];
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataA.count;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 40;
//}

@end
