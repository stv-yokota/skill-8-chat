//
//  PCChatViewController.m
//  PseudoChat
//
//  Created by yokotasan on 2017/07/09.
//  Copyright © 2017年 yokotasan. All rights reserved.
//

#import "PCChatViewController.h"

#import "PCChatFormView.h"
#import "PCChatTableViewCell.h"
#import "PCChatMessage+Addtions.h"

#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>

@interface PCChatViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, nullable) UITableView *tableView;

@property (nonatomic, strong, nullable) PCChatFormView *formView;

@property (nonatomic, strong, nullable) NSFetchedResultsController *fetchedResultsController;

@end

@implementation PCChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"メッセージ";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PCChatTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    self.formView = [[PCChatFormView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.formView];
}

- (void)viewDidLayoutSubviews
{
    {
        CGSize size = [self.formView sizeThatFits:self.view.frame.size];
        self.formView.frame = CGRectMake(0.0,
                                         self.view.frame.size.height - size.height,
                                         self.view.frame.size.width,
                                         size.height);
    }
    
    {
        self.tableView.frame = CGRectMake(self.view.frame.origin.x,
                                          self.view.frame.origin.y,
                                          self.view.frame.size.width,
                                          self.view.frame.size.height - self.formView.frame.size.height);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = [[self.fetchedResultsController sections] count];
    
    if (count == 0) {
        count = 1;
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PCChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

#pragma mark - private

- (void)configureCell:(PCChatTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    PCChatMessage *entity = (PCChatMessage *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.messageLabel.text = entity.message;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute
                                              fromDate:entity.time_stamp];
    
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)dateComps.hour, dateComps.minute];
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        _fetchedResultsController = [PCChatMessage MR_fetchAllSortedBy:@"time_stamp"
                                                             ascending:YES
                                                         withPredicate:nil
                                                               groupBy:@"dateSection"
                                                              delegate:self];
        
    }
    
    return _fetchedResultsController;
}


@end
