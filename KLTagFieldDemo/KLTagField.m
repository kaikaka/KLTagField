//
//  KLTagField.m
//  iKuaiLao
//
//  Created by xiangkai yin on 15/12/18.
//  Copyright © 2015年 kuailao_2. All rights reserved.
//

#import "KLTagField.h"
#import "KLBtnTag.h"

@interface KLTagField () {
  UIView              *_tagsView;//显示标签的视图
  UIView              *_paddingView;//间距视图
}

@end

@implementation KLTagField

- (id)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30)]) {
    [self setupUI];
  }
  
  return self;
}

-(id)init{
  return [self initWithFrame: CGRectMake(0, 0, 100, 30)];
}

-(void)setFrame:(CGRect)frame{
  super.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30);
}

- (void)setTagsArray:(NSArray *)tagsArray {
  _tagsArray = tagsArray;
  [self layoutTags];
}

//重写来重置文字区域
- (CGRect) textRectForBounds: (CGRect) bounds {
  CGRect origValue = [super textRectForBounds: bounds];
  
  return CGRectOffset(origValue, 0.0f, 3.0f);
}
//重写来重置编辑区域
- (CGRect) editingRectForBounds: (CGRect) bounds {
  CGRect origValue = [super textRectForBounds: bounds];
  
  return CGRectOffset(origValue, 0.0f, 3.0f);
}

-(void)awakeFromNib {
  [self setupUI];
  [super awakeFromNib];
}

-(void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:nil];
}

- (void)textFieldDidChange:(NSNotification*)aNotification {
  
  if(self.text.length == 0) return;
  
  //获取最后一个文本
  unichar lastChar = [self.text characterAtIndex:self.text.length - 1];
  
  //文本为空格或逗号，则生成标签按钮
  if(lastChar == ' ' ||
     lastChar == ','){
    //获取文本
    NSString *txtTag= [self.text substringToIndex: self.text.length - 1];
    
    if(txtTag.length == 0){
      self.text   = @"";
      return;
    }
    
    //如果不存在，则创建一个新的
    if([_tagsArray indexOfObject: txtTag] == NSNotFound){
      NSMutableArray *muteTags = [_tagsArray mutableCopy];
      [muteTags addObject: txtTag];
      _tagsArray = muteTags;
      
      //代理
      if([_tagDelegate respondsToSelector: @selector(tagField:tagAdded:)]){
        [_tagDelegate tagField:self tagAdded:txtTag];
      }
      
      [self layoutTags];
    }
    
    self.text = @"";
  }
}

- (void)textFieldDidEndEditing:(NSNotification*)aNotification{
  //结束编辑 移动光标
  if(self.text.length > 0)
    self.text = [self.text stringByAppendingString:@" "];
  
  [self textFieldDidChange: aNotification];
}

-(void)deleteBackward{
  if(_tagsArray.count > 0 && self.text.length == 0){
    //调用代理
    if([_tagDelegate respondsToSelector:@selector(tagField:tagRemoved:)]){
      NSString *lastTag = [_tagsArray lastObject];
      [_tagDelegate tagField:self tagRemoved: lastTag];
    }
    //从数组中移除
    NSMutableArray *muteTags = [_tagsArray mutableCopy];
    [muteTags removeLastObject];
    _tagsArray = muteTags;
    
    [self layoutTags];
  }
  
  [super deleteBackward];
}

#pragma mark - private methods

-(void)layoutTags {
  //移除标签视图的所有子视图
  [_tagsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  
  //重置视图大小
  CGRect tagsFrame = _tagsView.frame;
  tagsFrame.size = CGSizeMake(0, 0);
  _tagsView.frame = tagsFrame;
  
  CGRect paddingFrame = _paddingView.frame;
  paddingFrame.size.width = 0;
  _paddingView.frame = paddingFrame;
  
  //遍历来创建标签按钮
  for(NSString *txtTag in _tagsArray){
    KLBtnTag *tag = [[KLBtnTag alloc] initWithTag: txtTag];
    //按钮可近一步处理，这里不需要点击
//    [tag addTarget:self action:@selector(onTouchTagTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //重置标签view的位置
    CGRect tagFrame = tag.frame;
    tagFrame.origin.x = _tagsView.frame.size.width + 5;
    tagFrame.origin.y = (self.frame.size.height - tag.frame.size.height) / 2;
    tag.frame = tagFrame;
    
    //重置标签view的大小
    tagsFrame = _tagsView.frame;
    tagsFrame.size.width += (tag.frame.size.width + 5);
    _tagsView.frame = tagsFrame;
    
    //重置_paddingView 的宽度(必须，这样会保证焦点在应该显示的位置)
    paddingFrame = _paddingView.frame;
    paddingFrame.size.width = (_tagsView.frame.size.width + 5);
    _paddingView.frame = paddingFrame;
    
    [_tagsView addSubview: tag];
  }
  
  CGFloat missingWidth= (_tagsView.frame.size.width - self.frame.size.width + 40);
  //如果文本数量累计的宽度大于控件的宽度
  if(missingWidth > 0){
    // 移除原来的标签
    for(KLBtnTag *tag in _tagsView.subviews){
      //如果没有标签 不移除
      if(missingWidth < 0)
        break;
      
      missingWidth -= tag.frame.size.width;
      
      [tag removeFromSuperview];
    }
    
    //重置标签view的大小
    tagsFrame                   = _tagsView.frame;
    paddingFrame                = _paddingView.frame;
    
    tagsFrame.size.width        = 0;
    paddingFrame.size.width     = 0;
    
    _tagsView.frame              = tagsFrame;
    _paddingView.frame           = paddingFrame;
    
    // 复位,重置一遍
    for(KLBtnTag *tag in _tagsView.subviews){
      
      CGRect tagFrame         = tag.frame;
      tagFrame.origin.x       = _tagsView.frame.size.width + 5;
      tagFrame.origin.y       = (self.frame.size.height - tag.frame.size.height) / 2;
      tag.frame               = tagFrame;
      
      tagsFrame               = _tagsView.frame;
      tagsFrame.size.width   += (tag.frame.size.width + 5);
      _tagsView.frame          = tagsFrame;
      
      paddingFrame            = _paddingView.frame;
      paddingFrame.size.width = (_tagsView.frame.size.width + 5);
      _paddingView.frame       = paddingFrame;
      
      [_tagsView addSubview: tag];
    }
  }
}

-(void)setupUI {
  
  self.backgroundColor = [UIColor whiteColor];
  //是否不透明
  self.opaque = NO;
  //不自动更正文本样式
  self.autocorrectionType = UITextAutocorrectionTypeNo;
  //不显示边框
  self.borderStyle = UITextBorderStyleNone;
  
  _tagsArray = @[];
  
  _tagsView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
  
  _tagsView.backgroundColor = [UIColor clearColor];
  
  _paddingView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 0, 20)];
  
  _paddingView.backgroundColor = [UIColor clearColor];
  
  _paddingView.opaque = NO;
  
  //其实就是间距
  self.leftView = _paddingView;
  
  self.leftViewMode = UITextFieldViewModeAlways;
  
  //文本改变通知
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(textFieldDidChange:)
                                               name:@"UITextFieldTextDidChangeNotification"
                                             object:nil];
  //即将结束的通知
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(textFieldDidEndEditing:)
                                               name:@"UITextFieldTextDidEndEditingNotification"
                                             object:nil];
  
  
  if(![_tagsView isDescendantOfView: self])
    [self addSubview:_tagsView];
}

@end
