//
//  CoreDataCSVExporter.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 07.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

@interface CoreDataCSVExporter : NSObject

- (NSString *)exportManagedObject:(NSManagedObject *)managedObject;

- (NSString *)buildCSVData;

- (NSString *)getCSVString:(NSString *)csv forRun:(Run *)run;
@end
