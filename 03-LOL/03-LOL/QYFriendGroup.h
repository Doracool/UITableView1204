//
//  QYFriendGroup.h
//  03-LOL
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYFriendGroup : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *online;
@property (nonatomic,strong) NSArray *friends;
@property (nonatomic) BOOL isopen;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)friendGroupWithDict:(NSDictionary *)dict;

@end
