//
//  CoreDataCSVExporter.m
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 07.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "CoreDataCSVExporter.h"

#import "Touch.h"

@implementation CoreDataCSVExporter

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSString *)exportManagedObject:(NSManagedObject *)managedObject{
    NSString *csv = [self serializeManagedObject:managedObject];
    NSLog(csv);
    return csv;
}

-(NSString *)serializeManagedObject:(NSManagedObject *)managedObject{
    NSString *csv = @"";
    NSEntityDescription *entityDescription = [managedObject entity] ;
    NSDictionary *attributes = [entityDescription attributesByName];
    NSDictionary *relationships = [entityDescription relationshipsByName] ;
    NSMutableArray *values = [NSMutableArray array];
    for (NSString *attributeName in attributes) {
        id value = [managedObject valueForKey:attributeName];
        if (value != nil) {
            if ([value isKindOfClass:[NSString class]]){
                csv = [csv stringByAppendingFormat:@"%@,", value];
            } else if ([value isKindOfClass:[NSNumber class]]){
                csv = [csv stringByAppendingFormat:@"%d,", [value integerValue]];
            }  else if ([value isKindOfClass:[NSDate class]]){
                csv = [csv stringByAppendingFormat:@"%n,", [self toTimeStampString:value since:nil ]];
            }
        } else {
            csv = [csv stringByAppendingString:@","];
        }
    }


    return csv;
}

-(NSString *)buildCSVData {
    NSString *csv = @"RunID,StartRun,RunDuration,Block,Orientation,Usage,Color,IterationNr,ShowTargetsTime,HideTargetsTime,TargetSize,TargetX,TargetY,TouchX,TouchY,TouchTime,TouchDelay,TargetHit\n";
    DataManager *dataManager = [DataManager sharedManager] ;
    NSArray * runs = [dataManager getManagedObjectsWithName:@"Run"];
    for (Run *run in runs) {
        csv= [self getCSVString:csv forRun:run];

    }
    return csv;
}

- (NSString *)getCSVString:(NSString *)csv forRun:(Run *)run {
    if (csv== nil){
        csv = @"RunID,StartRun,RunDuration,Block,Orientation,Usage,Color,IterationNr,ShowTargetsTime,HideTargetsTime,TargetSize,TargetX,TargetY,TouchX,TouchY,TouchTime,TouchDelay,TargetHit\n";
    }
    NSOrderedSet *blocks = run.blocks;
    NSString * runString = [NSString stringWithFormat:@"%@,%@,%d,", run.runid, [self toDateTimeString:run.starttime], [self toTimeStampString:run.endtime since:run.starttime ]];

    for (Block * block in blocks) {
            NSOrderedSet *iterations = block.iterations;
            NSString *blockString = [NSString stringWithFormat:@"%d,%@,%@,%@,", [block.number integerValue], [block.orientation integerValue] == 0 ? @"portrait":@"landscape", [block.usage integerValue]==0?@"bothHanded":@"singleHanded", block.color];

            for (Iteration * iteration in iterations) {
                NSOrderedSet *touches = iteration.touches;
                NSString *iterationString = [NSString stringWithFormat:@"%d,%d,%d,%d,%d,%d,",[iteration.number integerValue],[self toTimeStampString:iteration.displaytime since:run.starttime ], [self toTimeStampString:iteration.disappearTime since:run.starttime ], [iteration.targetsize integerValue], [iteration.targetx integerValue], [iteration.targety integerValue]] ;
                 if (touches.count>0){
                     for (Touch * touch in touches) {
                         //if ([touch.isTargetTouch boolValue]){
                         NSString *touchString = [NSString stringWithFormat:@"%d,%d,%d,%d,%@\n", [touch.touchx integerValue], [touch.touchy integerValue], [self toTimeStampString:touch.timestamp since:run.starttime ],[self toTimeStampString:touch.timestamp since:run.starttime ]-[self toTimeStampString:iteration.displaytime since:run.starttime ],[touch.isTargetTouch boolValue]?@"yes":@"no"];
                         NSString *csvLineString = [NSString stringWithFormat:@"%@%@%@%@",runString, blockString, iterationString, touchString];
                         csv = [csv stringByAppendingString:csvLineString];
                         //}

                     }
                 }  else{
                     NSString *touchString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@\n", @"NaN", @"NaN", @"NaN",@"NaN",@"no"];
                     NSString *csvLineString = [NSString stringWithFormat:@"%@%@%@%@",runString, blockString, iterationString, touchString];
                     csv = [csv stringByAppendingString:csvLineString];
                 }


            }

        }
    return csv;
}

- (int)toTimeStampString:(id)value since:(NSDate *)startDate {
    NSDate *date = (NSDate *)value;
    int timestamp = (int) ([date timeIntervalSinceDate:startDate]*1000);
    //NSLog(@"%d", timestamp);
    return timestamp;

}

- (NSString *)toDateTimeString:(NSDate *)date  {



    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];


    //dateFormatter.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd'_'HH-mm"];

    //Optionally for time zone conversations
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"de_DE"]];

    NSString *stringFromDate =  [dateFormatter stringFromDate:date];

    return stringFromDate;


}

@end
