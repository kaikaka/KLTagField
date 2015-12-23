//
//  ViewController.m
//  KLTagFieldDemo
//
//  Created by XiangKai Yin on 12/23/15.
//  Copyright © 2015 yinxiangkai. All rights reserved.
//

#import "ViewController.h"

#import "KLTagField.h"
#import "KLTagFieldDelegate.h"

@interface ViewController ()<KLTagFieldDelegate>

@property (weak, nonatomic) IBOutlet KLTagField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _textField.tagDelegate = self;
  _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
  _textField.layer.borderWidth = 1.;
  _textField.layer.cornerRadius = 5.;
}

-(void) tagField: (KLTagField *) tagField tagAdded: (NSString *) tag {
  NSLog(@"tag = %@",tag);
}

-(void) tagField: (KLTagField *) tagField tagRemoved: (NSString *) tag {
  NSLog(@"tag = %@",tag);
}

@end
