//
//  KLBtnTag.h
//  iKuaiLao
//
//  Created by xiangkai yin on 15/12/18.
//  Copyright © 2015年 kuailao_2. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义标签button
 */
@interface KLBtnTag : UIButton

/**
 *  初始化
 *
 *  @param tag 文本值(既button 标题)
 */
- (id)initWithTag:(NSString *)tag;

/**
 *  tag 值
 */
@property (nonatomic, strong) NSString  *value;

/**
 *  边框颜色
 */
@property (nonatomic, strong) UIColor   *borderColor;

/**
 *  字体
 */
@property (nonatomic, strong) UIFont    *font;

/**
 *  文本颜色
 */
@property (nonatomic, strong) UIColor   *textColor;

@end
