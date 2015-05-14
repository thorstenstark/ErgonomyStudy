//
//  DataManager.h
//  ErgonomyStudy
//
//  Created by Thorsten on 28.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "Run.h"
#import "Block.h"
#import "Iteration.h"

@class Touch;

@interface DataManager : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) Run* currentRun;
@property (nonatomic, strong) Block* currentBlock;
@property (nonatomic, strong) Iteration* currentIteration;
@property(nonatomic, strong) Touch * currentTouch;

@property(nonatomic) int numberOfIterationsPerBlock;

- (void)saveContext;

- (Run *)createNewRunWithUserID:(NSString *)userID;

- (Run *)createNewRun;

- (Iteration *)createNewIteration;

- (Touch *)touchForCurrentIteration;

- (NSArray *)getManagedObjectsWithName:(NSString *)name;

- (NSURL *)applicationDocumentsDirectory;

+ (DataManager*)sharedManager;

- (Block *)createNewBlock;

- (NSString *)calculateCurrentSequence;

- (Block *)createNewBlockWithNumber:(int)blocknumber;

- (void)endRun;

- (void)clearData;

- (NSString *)exportCSV;

- (NSString *)exportRunCSV:(Run *)run;

- (NSArray *)allRuns;

- (int)numberForBlockConfigurationAtBlock:(int)group;

- (void)removeRunIfEmpty;
@end
