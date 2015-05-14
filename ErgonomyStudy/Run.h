//
//  Run.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 05.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Block;

@interface Run : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * deviceorientation;
@property (nonatomic, retain) NSDate * endtime;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * handed;
@property (nonatomic, retain) NSString * runid;
@property (nonatomic, retain) NSDate * starttime;
@property (nonatomic, retain) NSNumber * usage;
@property (nonatomic, retain) NSNumber * usagefrequency;
@property (nonatomic, retain) NSOrderedSet *blocks;
@end

@interface Run (CoreDataGeneratedAccessors)

- (void)insertObject:(Block *)value inBlocksAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBlocksAtIndex:(NSUInteger)idx;
- (void)insertBlocks:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBlocksAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBlocksAtIndex:(NSUInteger)idx withObject:(Block *)value;
- (void)replaceBlocksAtIndexes:(NSIndexSet *)indexes withBlocks:(NSArray *)values;
- (void)addBlocksObject:(Block *)value;
- (void)removeBlocksObject:(Block *)value;
- (void)addBlocks:(NSOrderedSet *)values;
- (void)removeBlocks:(NSOrderedSet *)values;
@end
