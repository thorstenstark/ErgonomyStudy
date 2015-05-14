//
//  Iteration.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 10.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Block, Touch;

@interface Iteration : NSManagedObject

@property (nonatomic, retain) NSDate * disappearTime;
@property (nonatomic, retain) NSNumber * displayedonly;
@property (nonatomic, retain) NSDate * displaytime;
@property (nonatomic, retain) NSNumber * targetsize;
@property (nonatomic, retain) NSNumber * targetx;
@property (nonatomic, retain) NSNumber * targety;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Block *block;
@property (nonatomic, retain) NSOrderedSet *touches;
@end

@interface Iteration (CoreDataGeneratedAccessors)

- (void)insertObject:(Touch *)value inTouchesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTouchesAtIndex:(NSUInteger)idx;
- (void)insertTouches:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTouchesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTouchesAtIndex:(NSUInteger)idx withObject:(Touch *)value;
- (void)replaceTouchesAtIndexes:(NSIndexSet *)indexes withTouches:(NSArray *)values;
- (void)addTouchesObject:(Touch *)value;
- (void)removeTouchesObject:(Touch *)value;
- (void)addTouches:(NSOrderedSet *)values;
- (void)removeTouches:(NSOrderedSet *)values;
@end
