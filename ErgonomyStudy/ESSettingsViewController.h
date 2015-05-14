//
//  ESSettingsViewController.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 20.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSettingsViewController : UIViewController  <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *longSideTargetsControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shortSideTargetsControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sectionsControl;
@property (weak, nonatomic) IBOutlet UISwitch *testSwitch;

@property(nonatomic, strong) UIAlertView *alertView;

- (IBAction)segmentedControlChanged:(id)sender;
- (IBAction)setTestRun:(id)sender;
@end
