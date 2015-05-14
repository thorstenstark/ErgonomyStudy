//
//  ESTouchTestViewController.h
//  ErgonomyStudy
//
//  Created by Thorsten on 19.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESRunViewController;
@class DataManager;

@interface ESTouchTestViewController : UIViewController <UIAlertViewDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSMutableArray *buttonGrid;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) NSTimer *breaktimer;
@property(nonatomic, strong) UIColor * targetColor;
@property(nonatomic, strong) ESRunViewController *delegate;
@property(nonatomic, strong) DataManager *dataManager;
@end
