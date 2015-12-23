//
//  KLTagField.h
//  iKuaiLao
//
//  Created by xiangkai yin on 15/12/18.
//  Copyright © 2015年 kuailao_2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLBtnTag.h"
#import "KLTagFieldDelegate.h"

/**
 *  自定义标签TextField
 */
@interface KLTagField : UITextField

/**
 *  包含了所有标签，可以手动设置
 */
@property (nonatomic, strong) NSArray *tagsArray;


@property (unsafe_unretained) id<KLTagFieldDelegate> tagDelegate;

@end
