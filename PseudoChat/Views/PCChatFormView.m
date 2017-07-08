//
//  PCChatFormView.m
//  PseudoChat
//
//  Created by yokotasan on 2017/07/09.
//  Copyright © 2017年 yokotasan. All rights reserved.
//

#import "PCChatFormView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PCChatFormView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIColor.lightGrayColor;
        
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.backgroundColor = UIColor.whiteColor;
        [self addSubview:_textView];
        
        _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_submitButton setTitle:@"送信" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(didButtonTouchUpInsdide)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_submitButton];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [self.submitButton sizeToFit];
    
    {
        CGSize size = [self.textView sizeThatFits:CGSizeMake(self.frame.size.width - self.submitButton.frame.size.width - 40.0,
                                                             CGFLOAT_MAX)];
        
        self.textView.frame = CGRectMake(10.0,
                                         10.0,
                                         self.frame.size.width - self.submitButton.frame.size.width - 40.0,
                                         size.height);
    }
    
    {
        self.submitButton.frame = CGRectMake(self.textView.frame.size.width + 30.0,
                                             10.0,
                                             self.submitButton.frame.size.width,
                                             self.submitButton.frame.size.height);
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize contentSize = CGSizeMake(size.width - 20.0, size.height - 20.0);
    CGFloat height = [self.textView sizeThatFits:contentSize].height + 20.0;
    
    return CGSizeMake(size.width, height);
}

- (void)didButtonTouchUpInsdide
{
    if (self.buttonAction)
    {
        self.buttonAction();
    }
}

@end

NS_ASSUME_NONNULL_END
