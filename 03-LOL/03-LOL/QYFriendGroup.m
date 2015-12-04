//
//  QYFriendGroup.m
//  03-LOL
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYFriendGroup.h"
#import "QYFriend.h"
@implementation QYFriendGroup
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in self.friends) {
            QYFriend *friend = [QYFriend friendWithDict:dic];
            [array addObject:friend];
            
        }
        self.friends = array;
//        self.isopen = YES;
    }
    return self;
}
+(instancetype)friendGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
