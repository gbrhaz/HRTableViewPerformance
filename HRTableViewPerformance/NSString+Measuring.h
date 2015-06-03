//
//  NSString+Measuring.h
//  HRTableViewPerformance
//
//  Created by Harry Richardson on 03/06/2015.
//  Copyright (c) 2015 Harry Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface NSString (Measuring)

- (CGSize)sizeConstrainedToSize:(CGSize)constrainedSize usingFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeConstrainedToSize:(CGSize)constrainedSize usingFont:(UIFont *)font withOptions:(NSStringDrawingOptions)options lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
