//
//  ViewController.m
//  HRTableViewPerformance
//
//  Created by Harry Richardson on 03/06/2015.
//  Copyright (c) 2015 Harry Richardson. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "Model.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *cachedHeights;
@property (nonatomic, strong) NSArray *models;

@end

@implementation ViewController

static NSString * const CellIdentifier = @"CellIdentifier";
static NSInteger const NumberOfModels = 1000;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cachedHeights = [NSMutableDictionary dictionary];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    NSMutableArray *models = [NSMutableArray array];
    for (NSInteger i = 0; i < NumberOfModels; i++) {
        [models addObject:[Model newModel]];
    }
    self.models = models;
    
    UINib *nib = [UINib nibWithNibName:@"Cell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    self.cachedHeights = [NSMutableDictionary dictionary];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Model *model = self.models[indexPath.row];
    [cell configureWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Model *model = self.models[indexPath.row];
    return [self estimatedHeightForRowWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Model *model = self.models[indexPath.row];
    return [self heightForRowWithModel:model];
}

#pragma mark - Measuring

- (CGFloat)estimatedHeightForRowWithModel:(Model *)model {
    NSNumber *key = @([model hash]);
    NSNumber *height = self.cachedHeights[key];
    if (height) {
        return [height floatValue];
    } else {
        return 150.0f;
    }
}

- (CGFloat)heightForRowWithModel:(Model *)model {
    NSNumber *key = @([model hash]);
    
    NSNumber *height = self.cachedHeights[key];
    if (height) {
        return [height floatValue];
    }
    
    static Cell *prototypeCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    });
    
    [prototypeCell configureForHeightWithModel:model];
    
    // Either choose the 4 lines below "AUTOLAYOUT" to let the autolayout engine deal with everything; or the two lines
    // below "MANUAL MEASURING" to measure the labels in the strings themselves to determine the height of the cell
    
    // AUTOLAYOUT
//    prototypeCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(prototypeCell.bounds));
//    [prototypeCell layoutIfNeeded];
//    CGSize size = [prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    CGFloat actualHeight = size.height + 1;
    
    // MANUAL MEASURING
    CGFloat measuredHeight = [prototypeCell measuredHeight];
    CGFloat actualHeight = measuredHeight + 1;
    self.cachedHeights[key] = @(actualHeight);
    
    return actualHeight;
}


@end
