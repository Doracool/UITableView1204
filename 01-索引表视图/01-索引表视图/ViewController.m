//
//  ViewController.m
//  01-索引表视图
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) NSArray *keys;
@end

@implementation ViewController
static NSString *QYID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self LoadDictFromFile];
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableView];
    tableView.dataSource =self;
    tableView.delegate = self;
    
    //当行数超过多少不显示
    tableView.sectionIndexMinimumDisplayRowCount = 1000;
    //索引文本颜色
    tableView.sectionIndexColor = [UIColor greenColor];
    
    //背景颜色
    tableView.backgroundColor = [UIColor grayColor];
    
    //选中背景颜色
    tableView.sectionIndexTrackingBackgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)LoadDictFromFile
{
    NSString *path = [[NSBundle  mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //取出字典中所有的键
    NSArray *keys = _dict.allKeys;
    //paixu
    _keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count;
}

//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = _keys[section];
    
    NSArray *array = _dict[key];
    return array.count;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QYID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QYID];
        
    }
    NSString *key = _keys[indexPath.section];
    NSArray *array = _dict[key];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
//设置头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _keys[section];
}

//设置索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
