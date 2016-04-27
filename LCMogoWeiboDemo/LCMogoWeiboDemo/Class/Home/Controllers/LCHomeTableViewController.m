//
//  LCHomeTableViewController.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCHomeTableViewController.h"
#import "LCTableView.h"
#import "LCStatusCell.h"
#import "LCTestViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "LCUserInfoReformer.h"
#import "LCStatusesListReformer.h"
@interface LCHomeTableViewController ()<LCBaseReformerDelegate , UITableViewDelegate, UITableViewDataSource>
@property (nonatomic , strong) LCUserInfoReformer *userReformer;
@property (nonatomic , strong) LCStatusesListReformer *listReformer;
@property (nonatomic , strong) LCTableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , assign) NSUInteger page;
@end

@implementation LCHomeTableViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (LCUserInfoReformer *)userReformer{
    if (!_userReformer) {
        _userReformer = [[LCUserInfoReformer alloc]init];
        _userReformer.delegate = self;
        _userReformer.uid = @1170999005;
        _userReformer.access_token = @"2.00j15PRBdmFKEBc0e4acca150rXv9S";
    }
    return _userReformer;
}
- (LCStatusesListReformer *)listReformer{
    if (!_listReformer) {
        self.page = 1;
        _listReformer = [[LCStatusesListReformer alloc]init];
        _listReformer.delegate = self;
        _listReformer.access_token = @"2.00j15PRBdmFKEBc0e4acca150rXv9S";
        _listReformer.identfier = @"address_list";

    }
    return _listReformer;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[LCTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.isAllowShowNullView = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.promptStr = @"没有数据";
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigtionItem];
        __weak __typeof(self) weakSelf = self;
    [self.tableView addRefreshHeader:^{
        weakSelf.page = 1;
        NSLog(@"%lu",weakSelf.page);
        [weakSelf.listReformer refreshDataWithPage:1];
    }];
        //    [self.userReformer requestDataWithHUDView:self.view];
 
    [self.listReformer requestDataWithHUDView:self.view];

    // Do any additional setup after loading the view.
}
- (void)reformerSuccessWith:(LCBaseReformer *)reformer{
    [self removeExceptionFrom:self.view];
    if ([reformer isKindOfClass:[LCStatusesListReformer class]]) {
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:self.listReformer.statusesModels];
        [self.tableView reloadData];
        self.page++;

        LCLogVerbose(@"%lu",self.listReformer.statusesModels.count);
    }
//    LCLogVerbose(@"%@",self.userReformer.userInfoModel);
}
-(void)reformerFailureWith:(LCBaseReformer *)reformer{
    if ([reformer isKindOfClass:[self.listReformer class]]) {
        if (self.listReformer.isRefresh == NO) {
            [self showLoadFaildIn:self.view showFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) refreshBlock:^{
                [self.listReformer requestDataWithHUDView:nil];
            }];
        }
    }
}

- (void)reformerGetAppCacheWith:(LCBaseReformer *)reformer{
    if ([reformer isKindOfClass:[LCStatusesListReformer class]]) {
        self.page ++;
        [self.dataArray addObjectsFromArray:self.listReformer.statusesModels];
        [self.tableView reloadData];
//                LCLogVerbose(@"%@",self.listReformer.statusesModels);
    }
}
- (void)setNavigtionItem{
    self.navigationItem.title = @"沉淀繁华";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:nil action:nil];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LCStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[LCStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        [cell addTopLineWithTopMargin:0 leftMargin:0 rightMargin:0];
        [cell setTopLineHeight:kBorderCellLineThickness];

//        [cell addDownLineWithDownMargin:0 leftMargin:0 rightMargin:0];
//        [cell setDownLineHeight:kBorderCellLineThickness];
    }
    cell.frameModel = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
   

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataArray[indexPath.row] cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LCTestViewController *testVC = [[LCTestViewController alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
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
- (void)netStateChangedMessage:(NSString *)netState{
    __weak __typeof(self) weakSelf = self;
    if ([netState isEqualToString:kNetConnected]) {
        self.tableView.tableFooterView = nil;
        [self.tableView addRefreshFooter:^{
            if (weakSelf.page == 1) {
                return;
            }
            NSLog(@"weakSelf%lu",weakSelf.page);

            [weakSelf.listReformer refreshDataWithPage:weakSelf.page];
        }];
    }else{
        [self.tableView removeRefreshFooter];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        view.backgroundColor = [UIColor redColor];
        weakSelf.tableView.tableFooterView = view;
    }
}
@end
