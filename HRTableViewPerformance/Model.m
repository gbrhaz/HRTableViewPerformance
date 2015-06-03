//
//  Model.m
//  HRTableViewPerformance
//
//  Created by Harry Richardson on 03/06/2015.
//  Copyright (c) 2015 Harry Richardson. All rights reserved.
//

#import "Model.h"

static NSString * const LorumIpsum = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras purus turpis, bibendum eget egestas in, sagittis eget mi. Aliquam nec feugiat eros. Vivamus molestie maximus ornare. Morbi pretium magna vitae eros posuere vehicula. In hac habitasse platea dictumst. Suspendisse quis nisl ultrices, pulvinar quam eget, consequat diam. Vivamus sit amet lectus mattis, sollicitudin dui non, fringilla dolor. Aliquam mattis sapien libero, sed fermentum est molestie sed. Mauris vel justo sem. Suspendisse urna arcu, dapibus in urna malesuada, viverra lobortis sem. Integer hendrerit, tellus nec tristique aliquam, felis metus pretium sem, et ornare leo diam a tellus. Sed tincidunt, massa vitae cursus fringilla, lorem lorem rhoncus nunc, a fermentum purus magna vel mi. In commodo, enim quis aliquam eleifend, lorem eros luctus risus, sit amet semper augue nunc et enim. Sed lectus erat, viverra in scelerisque vel, cursus at nulla.";

@interface Model()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *text;
@end

@implementation Model

+ (instancetype)newModel {
    Model *model = [Model new];
    
    model.title = @"Harry Richardson";
    model.subTitle = @"03/06/2015";
    
    NSInteger position = (arc4random() % LorumIpsum.length-20) + 20;
    model.text = [LorumIpsum substringToIndex:position];
    
    return model;
}

- (NSInteger)hash {
    return [self.title hash] ^ [self.subTitle hash] ^ [self.text hash];
}

@end
