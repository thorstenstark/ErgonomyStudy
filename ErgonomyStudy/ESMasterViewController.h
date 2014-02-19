//
//  ESMasterViewController.h
//  ErgonomyStudy
//
//  Created by Thorsten on 19.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESDetailViewController;

#import <CoreData/CoreData.h>

@interface ESMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) ESDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
