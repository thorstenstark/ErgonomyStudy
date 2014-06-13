//
//  Touch.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 05.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Iteration;

@interface Touch : NSManagedObject

@property (nonatomic, retain) NSNumber * isTargetTouch;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * touchx;
@property (nonatomic, retain) NSNumber * touchy;
@property (nonatomic, retain) Iteration *iteration;

@end
