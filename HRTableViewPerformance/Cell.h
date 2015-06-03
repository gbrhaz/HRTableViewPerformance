//
//  Cell.h
//  HRTableViewPerformance
//
//  Created by Harry Richardson on 03/06/2015.
//  Copyright (c) 2015 Harry Richardson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Model;

@interface Cell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *topLabel;
@property (nonatomic, weak) IBOutlet UILabel *middleLabel;
@property (nonatomic, weak) IBOutlet UILabel *bottomLabel;

- (void)configureWithModel:(Model *)model;
- (void)configureForHeightWithModel:(Model *)model;

- (CGFloat)measuredHeight;

@end
