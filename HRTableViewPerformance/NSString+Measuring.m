//
//  NSString+Measuring.m
//  HRTableViewPerformance
//
//  Created by Harry Richardson on 03/06/2015.
//  Copyright (c) 2015 Harry Richardson. All rights reserved.
//

#import "NSString+Measuring.h"

@implementation NSString (Measuring)

- (CGSize)sizeConstrainedToSize:(CGSize)constrainedSize usingFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode {
    return [self sizeConstrainedToSize:constrainedSize
                             usingFont:font
                           withOptions:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                         lineBreakMode:lineBreakMode];
}

- (CGSize)sizeConstrainedToSize:(CGSize)constrainedSize usingFont:(UIFont *)font withOptions:(NSStringDrawingOptions)options lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle}];
    CGRect rect = [attributedText boundingRectWithSize:constrainedSize options:options context:nil];
    CGSize textSize = CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
    
    return textSize;
}


@end
