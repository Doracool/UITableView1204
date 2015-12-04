//
//  QYSectionHeaderView.m
//  03-LOL
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYSectionHeaderView.h"
#import "QYFriendGroup.h"

@interface QYSectionHeaderView ()
@property (nonatomic,strong) UIButton *bgBtn;
@property (nonatomic,strong) UILabel *label;
@end

@implementation QYSectionHeaderView
static NSString *headerViewIdentifier = @"headerView";
+(instancetype)sectionHeaderViewForTableView:(UITableView *)tableView
{
    //和单元格方法相似
    QYSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
    if (headerView == nil) {
        headerView = [[QYSectionHeaderView alloc] initWithReuseIdentifier:headerViewIdentifier];
    }
    return headerView;
}


//重写系统默认的方法
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //添加背景btn
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:bgBtn];
        
        //设置背景
        UIImage *image = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        [bgBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        //设置高亮背景
        UIImage *highLighedImage = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 1, 44, 0) resizingMode:UIImageResizingModeStretch];
        [bgBtn setBackgroundImage:highLighedImage forState:UIControlStateHighlighted];
        
        //设置图标
        [bgBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        //设置标题字体颜色
        [bgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置内容的显示
        bgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        bgBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        bgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        //添加点击事件
        [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置bgBtn的视图的内容的显示模式
        bgBtn.imageView.contentMode = UIViewContentModeCenter;
        bgBtn.imageView.clipsToBounds = NO;
        
        //添加label （在线人数/总人数）
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        //label的位置在右边
        label.textAlignment = NSTextAlignmentRight;
        
        _bgBtn = bgBtn;
        _label = label;
        
    }
    return self;
}

//重写位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置bgBtn的frame
    _bgBtn.frame = self.bounds;
    
    //设置label的frame
    CGFloat labelW = 100;
    CGFloat labelH = self.bounds.size.height;
    CGFloat labelX = self.bounds.size.width - labelW - 10 ;
    CGFloat labelY = 0;
    _label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}
-(void)bgBtnClick:(UIButton *)btn
{
    _friendGroup.isopen = !_friendGroup.isopen;
    
    if (_headerViewClick) {
        _headerViewClick();
    }
}

-(void)setFriendGroup:(QYFriendGroup *)friendGroup
{
    _friendGroup = friendGroup;
    
    [_bgBtn setTitle:friendGroup.name forState:UIControlStateNormal];
    _label.text = [NSString stringWithFormat:@"%@/%ld",friendGroup.online,friendGroup.friends.count];
    
    if (_friendGroup.isopen) {
        _bgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        _bgBtn.imageView.transform = CGAffineTransformIdentity;
    }
}
@end
