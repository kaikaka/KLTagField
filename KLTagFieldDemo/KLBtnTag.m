//
//  KLBtnTag.m
//  iKuaiLao
//
//  Created by xiangkai yin on 15/12/18.
//  Copyright © 2015年 kuailao_2. All rights reserved.
//

#import "KLBtnTag.h"

@implementation KLBtnTag
@synthesize value;
@dynamic borderColor, font, textColor;


- (id)initWithTag:(NSString *)tag {
  if(self = [super init]){
    self.backgroundColor = [UIColor colorWithRed:254./255. green:199./255. blue:110./255. alpha:1.0];
    
    self.titleLabel.font = [UIFont systemFontOfSize: 14];
    
    self.layer.cornerRadius = 12;
    
    self.layer.masksToBounds = YES;
    //边框
    self.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.layer.borderWidth = 1;
    
    self.showsTouchWhenHighlighted = YES;
    
    value = tag;
    //空格是为了保持间距
    [self setTitle:[NSString stringWithFormat:@"    %@    ", tag] forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置
    [self sizeToFit];
    
    CGRect selfFrame = self.frame;
    
    selfFrame.size.height = 25;
    
    self.frame = selfFrame;
  }
  
  return self;
}

-(void)setValue:(NSString *)aValue{
  [self setTitle:[NSString stringWithFormat:@"    %@    ", aValue] forState:UIControlStateNormal];
  self.value = aValue;
}

-(UIColor *)borderColor{
  return [UIColor colorWithCGColor: self.layer.borderColor];
}

-(void)setBorderColor:(UIColor *)borderColor{
  self.layer.borderColor = borderColor.CGColor;
}

-(UIFont *)font{
  return self.titleLabel.font;
}

-(void)setFont:(UIFont *)font{
  self.titleLabel.font = font;
}

-(UIColor *)textColor{
  return [self titleColorForState: UIControlStateNormal];
}

-(void)setTextColor:(UIColor *)textColor{
  [self setTitleColor:textColor forState:UIControlStateNormal];
}

@end
