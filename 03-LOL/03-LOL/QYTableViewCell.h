//
//  QYTableViewCell.h
//  03-LOL
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYFriend;
@interface QYTableViewCell : UITableViewCell
@property (nonatomic,strong) QYFriend *friend;
@end
