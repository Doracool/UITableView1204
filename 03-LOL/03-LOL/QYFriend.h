//
//  QYFriend.h
//  03-LOL
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYFriend : NSObject

@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic) BOOL vip;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)friendWithDict:(NSDictionary *)dict;

@end
