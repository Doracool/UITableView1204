//
//  ViewController.m
//  03-LOL
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYFriendGroup.h"
#import "QYFriend.h"
#import "QYTableViewCell.h"
#import "QYSectionHeaderView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *heros;
@end

@implementation ViewController
static NSString *QYID = @"cell";
//懒加载
-(NSArray *)heros
{
    if (_heros == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hero" ofType:@"plist"];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            QYFriendGroup *friendGroup = [QYFriendGroup friendGroupWithDict:dict];
            [models addObject:friendGroup];
        }
        _heros = models;
    }
    return _heros;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.heros.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QYFriendGroup *friendGroup = self.heros[section];
    if (friendGroup.isopen) {
        return friendGroup.friends.count;
    }
    return 0;
}

//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QYID];
    if (cell == nil) {
        cell = [[QYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:QYID];
    }
    
    QYFriendGroup *friendGroup = self.heros[indexPath.section];
    QYFriend *friend = friendGroup.friends[indexPath.row];
    cell.friend = friend;
    return cell;

}

#if 0
//头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    QYFriendGroup *friendGroup = self.heros[section];
    return friendGroup.name;
}
#endif
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建自定义的section的头视图
    QYSectionHeaderView *headerView = [QYSectionHeaderView sectionHeaderViewForTableView:tableView];
    QYFriendGroup *friendGroup = self.heros[section];
    headerView.friendGroup = friendGroup;
    
    headerView.headerViewClick = ^{
        [tableView reloadData];
    };
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
