//
//  KLTagFieldDelegate.h
//  iKuaiLao
//
//  Created by xiangkai yin on 15/12/18.
//  Copyright © 2015年 kuailao_2. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KLTagField;
@protocol KLTagFieldDelegate <NSObject>

@optional

/**
 *  添加一个标签
 *
 *  @param tagField 标签文本框
 *  @param tag      标签
 */
-(void) tagField: (KLTagField *) tagField tagAdded: (NSString *) tag;

/**
 *  删除一个标签
 *
 *  @param tagField 标签文本框
 *  @param tag      标签
 */
-(void) tagField: (KLTagField *) tagField tagRemoved: (NSString *) tag;

/**
 *  文本标签改变
 *
 *  @param tagField 标签文本框
 *  @param tags     标签
 */
-(void) tagField: (KLTagField *) tagField tagsChanged: (NSArray *) tags;

@end
