//
//  PCChatMessage+Addtions.m
//  PseudoChat
//
//  Created by yokotasan on 2017/07/09.
//  Copyright © 2017年 yokotasan. All rights reserved.
//

#import "PCChatMessage+Addtions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PCChatMessage (Addtions)

- (NSString *)dateSection
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    if (self.time_stamp)
    {
        return [formatter stringFromDate:self.time_stamp];
    }
    
    return @"";
}

@end

NS_ASSUME_NONNULL_END
