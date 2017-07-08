//
//  PCChatTableViewCell.m
//  PseudoChat
//
//  Created by yokotasan on 2017/07/09.
//  Copyright © 2017年 yokotasan. All rights reserved.
//

#import "PCChatTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PCChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundView.backgroundColor = UIColor.whiteColor;
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _messageLabel.layer.cornerRadius = 10.0;
        _messageLabel.backgroundColor = UIColor.blueColor;
        _messageLabel.textColor = UIColor.whiteColor;
        _messageLabel.font = [UIFont systemFontOfSize:11.0];
        [self.backgroundView addSubview:_messageLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.backgroundColor = UIColor.clearColor;
        _timeLabel.textColor = UIColor.lightGrayColor;
        _timeLabel.font = [UIFont systemFontOfSize:9.0];
        [self.backgroundView addSubview:_timeLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    {
        CGSize size = [self.messageLabel sizeThatFits:CGSizeMake(self.frame.size.width - 20.0,
                                                                 CGFLOAT_MAX)];
        self.messageLabel.frame = CGRectMake(10.0, 4.0, size.width, size.height);
    }
    
    {
        CGSize size = [self.timeLabel sizeThatFits:CGSizeMake(self.frame.size.width - 20.0,
                                                              CGFLOAT_MAX)];
        self.timeLabel.frame = CGRectMake(self.frame.size.width - 10.0 - size.width,
                                          4.0 + self.messageLabel.frame.size.height + 6.0,
                                          size.width,
                                          size.height);
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize contentSize = CGSizeMake(size.width - 20.0, size.height - 4.0);
    
    CGFloat height = 4.0 + [self.messageLabel sizeThatFits:contentSize].height + 6.0 + [self.timeLabel sizeThatFits:contentSize].height;
    
    return CGSizeMake(size.width, height);
}

@end

NS_ASSUME_NONNULL_END
