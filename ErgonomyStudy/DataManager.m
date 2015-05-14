//
//  DataManager.m
//  ErgonomyStudy
//
//  Created by Thorsten on 28.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "DataManager.h"
#import "Touch.h"
#import "CoreDataCSVExporter.h"

@implementation DataManager {
    int iterationCount;
    NSString * _currentSequence;
    NSArray *_possibleSequences;
    dispatch_queue_t backgroundQueue;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static DataManager *sharedDataManager = nil;

+ (DataManager*)sharedManager
{
    if (sharedDataManager == nil) {
        sharedDataManager = [[super allocWithZone:nil ]init];
    }
    return sharedDataManager;
}

#pragma mark Initialization

-(id)init{
    self = [super init];
    if (self) {
        NSManagedObjectContext* context = [self managedObjectContext];
        NSFetchRequest* request = [[NSFetchRequest alloc]init];
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"Run" inManagedObjectContext:context];
        [request setEntity:entity];

        NSArray* results = [context executeFetchRequest:request error:nil];
        //iterate through results
        if ([results count]<1) {
            //[self loadDataFromFile:@"data.plist"];
            NSLog(@"No Data Found");
        }else{
            for (NSManagedObject* object in results) {
                NSLog(@"Found: %@", [object valueForKey:@"starttime"]);
            }
        }
    }
    backgroundQueue = dispatch_queue_create("com.beuth-hochschule.momo", NULL);
    _numberOfIterationsPerBlock = 20;

    _possibleSequences = @[@"ABCD",@"CDAB",@"DCBA",@"BADC"];

    return self;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ErgonomyStudy" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ErgonomyStudy.sqlite"];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.

         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.


         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]

         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}

         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

#pragma mark - Core Data Accessories

-(Run *)createNewRunWithUserID:(NSString *)userID{
    Run *run = [self createNewRun];
    run.runid = [_currentSequence stringByAppendingFormat:@"_%@",userID];

    [self saveContext];
     return run;
}

-(Run*)createNewRun{
    [self saveContext];
    //[self calculateCurrentSequence];

    _currentRun = [NSEntityDescription insertNewObjectForEntityForName:@"Run" inManagedObjectContext:self.managedObjectContext];
    _currentRun.starttime = [NSDate date];

    iterationCount=0;

    [self saveContext];

    return _currentRun;
}

- (NSString *)calculateCurrentSequence {
    NSArray *runs = [self getManagedObjectsWithName:@"Run"];
    int sequencePosition = (int)([runs count]%4);
    _currentSequence = [_possibleSequences objectAtIndex:sequencePosition];
    return _currentSequence;

}

- (Block *)createNewBlockWithNumber:(int)blocknumber {
    Block *block = [self createNewBlock];
    block.number = [NSNumber numberWithInt:blocknumber];
    return block;
}

- (Block *)createNewBlock {
    [self saveContext];

    _currentBlock = [NSEntityDescription insertNewObjectForEntityForName:@"Block" inManagedObjectContext:self.managedObjectContext];
    _currentBlock.run = _currentRun;
    NSMutableOrderedSet* blocks = [_currentRun mutableOrderedSetValueForKey:@"blocks"];
    [blocks addObject:_currentBlock];


    [self saveContext];

    return _currentBlock;
}

-(Iteration*)createNewIteration{
    [self saveContext];
    //Testausgabe
    //NSLog(@"x %d, y %d", [_currentIteration.targetx integerValue], [_currentIteration.targety integerValue]);
    //---
    _currentIteration = [NSEntityDescription insertNewObjectForEntityForName:@"Iteration" inManagedObjectContext:self.managedObjectContext];
    _currentIteration.displaytime = [NSDate date];
    _currentIteration.block = _currentBlock;
    iterationCount++;
    _currentIteration.number = [NSNumber numberWithInt:iterationCount];
    NSMutableOrderedSet* iterations = [_currentBlock mutableOrderedSetValueForKey:@"iterations"];
    [iterations addObject:_currentIteration];

    [self saveContext];
    return _currentIteration;
}

-(Touch *)touchForCurrentIteration{
    [self saveContext];

    _currentTouch = [NSEntityDescription insertNewObjectForEntityForName:@"Touch" inManagedObjectContext:self.managedObjectContext];
    _currentTouch.timestamp = [NSDate date];
    _currentTouch.iteration = _currentIteration;
    NSMutableOrderedSet* touches = [_currentIteration mutableOrderedSetValueForKey:@"touches"];
    [touches addObject:_currentTouch];

    [self saveContext];

    return _currentTouch;
}

- (void)endRun {
    _currentRun.endtime = [NSDate date];
    [self saveContext];
    dispatch_async(backgroundQueue, ^(void){
        [self exportRunCSV:_currentRun];
    })  ;
}

#pragma mark - Clear Core Data

-(void)clearData{
    //favoriteIDs = [self FavoritesIDs];
    //[_managedObjectContext deletedObjects];
    [self deleteAllManagedObjectsOfType:@"Run"];
    [self deleteAllManagedObjectsOfType:@"Block"];
    [self deleteAllManagedObjectsOfType:@"Iteration"];
    [self deleteAllManagedObjectsOfType:@"Touch"];
    // Delete Persitent Store and SQLITE File
    //NSPersistentStoreCoordinator *storeCoordinator = [self persistentStoreCoordinator];
    //NSPersistentStore *store = [_persistentStoreCoordinator.persistentStores objectAtIndex:0];
    //NSError *error;
    //NSURL *storeURL = store.URL;
    //[_persistentStoreCoordinator removePersistentStore:store error:&error];
    //[[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error];

    //_persistentStoreCoordinator = nil;
    [self saveContext];
}

-(void)deleteAllManagedObjectsOfType:(NSString*)typeName{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:typeName inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];

    NSArray *result = [_managedObjectContext executeFetchRequest:request error:nil];
    for (NSManagedObject* obj in result) {
        [_managedObjectContext deleteObject:obj];
    }

}

-(NSArray *)getManagedObjectsWithName:(NSString *)name{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];

    NSArray *result = [_managedObjectContext executeFetchRequest:request error:nil];
    return result;
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSString *)exportCSV {
    CoreDataCSVExporter *csvExporter = [CoreDataCSVExporter new];
    //NSArray * runs = [self getManagedObjectsWithName:@"Run"];
    NSString * csv = [csvExporter buildCSVData];
    NSString *documentsDirectory = [NSHomeDirectory()
            stringByAppendingPathComponent:@"Documents"];

    NSString *filePath = [documentsDirectory
            stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@.csv",[self shortTime]]];
    [csv writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return csv;
}

- (NSString *)exportRunCSV:(Run *)run {
    CoreDataCSVExporter *csvExporter = [CoreDataCSVExporter new];
    //NSArray * runs = [self getManagedObjectsWithName:@"Run"];
    NSString * csv = [csvExporter getCSVString:nil forRun:run];
    NSString *documentsDirectory = [NSHomeDirectory()
            stringByAppendingPathComponent:@"Documents"];

    NSString *filePath = [documentsDirectory
            stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@_%@.csv", [self shortTime],run.runid]];
    [csv writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return csv;
}

- (NSString *)shortTime {
    NSDate *date = [NSDate date];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];


    //dateFormatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd'_'HH-mm"];

    //Optionally for time zone conversations
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"de_DE"]];

    NSString *stringFromDate =  [dateFormatter stringFromDate:date];

    return stringFromDate;
}


- (int)numberForBlockConfigurationAtBlock:(int)group {
    NSLog(@"numberForBlockGroup: %d", group);
    unichar character = [_currentSequence characterAtIndex:group];
    int blockNumber = 0;
    switch (character) {
        case 'A':
            break;
        case 'B':
            blockNumber = 1;
            break;
        case 'C':
            blockNumber = 2;
            break;
        case 'D':
            blockNumber = 3;
            break;
        default:
            break;
    }
    return blockNumber;
}


- (void)removeRunIfEmpty {
    if (_currentRun.blocks.count==0){
        [_managedObjectContext deleteObject:_currentRun];
        [self saveContext];
    }

}
@end
