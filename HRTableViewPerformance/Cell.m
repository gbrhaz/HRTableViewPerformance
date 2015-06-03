//
//  Cell.m
//  HRTableViewPerformance
//
//  Created by Harry Richardson on 03/06/2015.
//  Copyright (c) 2015 Harry Richardson. All rights reserved.
//

#import "Cell.h"
#import "Model.h"
#import "NSString+Measuring.h"

@interface Cell()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topMargin;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomMargin;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topMiddleSpacing;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *middleBottomSpacing;

@end

@implementation Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topLabel.font = [UIFont boldSystemFontOfSize:16];
    self.middleLabel.font = [UIFont systemFontOfSize:14];
    self.bottomLabel.font = [UIFont systemFontOfSize:14];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    
    self.topLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.topLabel.frame);
    self.middleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.middleLabel.frame);
    self.bottomLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bottomLabel.frame);
}

- (void)configureWithModel:(Model *)model {
    self.topLabel.text = model.title;
    self.middleLabel.text = model.subTitle;
    self.bottomLabel.text = model.text;
}

- (void)configureForHeightWithModel:(Model *)model {
    // In this cell, it'd be the same because we always need to measure the labels
    [self configureWithModel:model];
}

- (CGFloat)measuredHeight {
    CGFloat measuredHeight = 0;
    measuredHeight += self.topMargin.constant + self.bottomMargin.constant + self.topMiddleSpacing.constant + self.middleBottomSpacing.constant;
    
    CGFloat topLabelMaxHeight = ceilf(self.topLabel.font.lineHeight * self.topLabel.numberOfLines);
    measuredHeight += [self.topLabel.text sizeConstrainedToSize:CGSizeMake(self.topLabel.frame.size.width, topLabelMaxHeight)
                                                      usingFont:self.topLabel.font
                                                    withOptions:NSStringDrawingUsesLineFragmentOrigin
                                                  lineBreakMode:NSLineBreakByWordWrapping].height;
    
    CGFloat middleLabelMaxHeight = ceilf(self.middleLabel.font.lineHeight) *self.middleLabel.numberOfLines;
    measuredHeight += [self.middleLabel.text sizeConstrainedToSize:CGSizeMake(self.middleLabel.frame.size.width, middleLabelMaxHeight)
                                                         usingFont:self.middleLabel.font
                                                       withOptions:NSStringDrawingUsesLineFragmentOrigin
                                                     lineBreakMode:NSLineBreakByWordWrapping].height;
    
    measuredHeight += [self.bottomLabel.text sizeConstrainedToSize:CGSizeMake(self.bottomLabel.frame.size.width, CGFLOAT_MAX)
                                                         usingFont:self.bottomLabel.font
                                                       withOptions:NSStringDrawingUsesLineFragmentOrigin
                                                     lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return measuredHeight;
}

@end
