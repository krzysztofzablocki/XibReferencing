//
//  UIView+NibLoading.m
//  XibReferencing
//
//  Created by Krzysztof Zablocki on 12/26/12.
//  Copyright (c) 2012 Pixle. All rights reserved.
//

#import "UIView+NibLoading.h"
const int kNibReferencingTag = 616;

@implementation UIView (NibLoading)

+ (id)loadInstanceFromNib
{
  UIView *result = nil;
  NSArray *elements = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
  for (id anObject in elements) {
    if ([anObject isKindOfClass:[self class]]) {
      result = anObject;
      break;
    }
  }
  return result;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
  if (self.tag == kNibReferencingTag) {
    //! placeholder
    UIView *realView = [[self class] loadInstanceFromNib];
    realView.frame = self.frame;
    realView.alpha = self.alpha;
    realView.backgroundColor = self.backgroundColor;
    realView.autoresizingMask = self.autoresizingMask;
    realView.autoresizesSubviews = self.autoresizesSubviews;
    
    for (UIView *view in self.subviews) {
      [realView addSubview:view];
    }
    return realView;
  }
  return [super awakeAfterUsingCoder:aDecoder];
}
@end
