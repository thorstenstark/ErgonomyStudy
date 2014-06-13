//
//  Block.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 05.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Iteration, Run;

@interface Block : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * orientation;
@property (nonatomic, retain) NSNumber * usage;
@property (nonatomic, retain) NSOrderedSet *iterations;
@property (nonatomic, retain) Run *run;
@end

@interface Block (CoreDataGeneratedAccessors)

- (void)insertObject:(Iteration *)value inIterationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromIterationsAtIndex:(NSUInteger)idx;
- (void)insertIterations:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeIterationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInIterationsAtIndex:(NSUInteger)idx withObject:(Iteration *)value;
- (void)replaceIterationsAtIndexes:(NSIndexSet *)indexes withIterations:(NSArray *)values;
- (void)addIterationsObject:(Iteration *)value;
- (void)removeIterationsObject:(Iteration *)value;
- (void)addIterations:(NSOrderedSet *)values;
- (void)removeIterations:(NSOrderedSet *)values;
@end
