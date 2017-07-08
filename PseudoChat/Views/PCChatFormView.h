//
//  PCChatFormView.h
//  PseudoChat
//
//  Created by yokotasan on 2017/07/09.
//  Copyright © 2017年 yokotasan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PCChatFormViewAction)();

@interface PCChatFormView : UIView

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, copy, nullable) PCChatFormViewAction buttonAction;

@end

NS_ASSUME_NONNULL_END
