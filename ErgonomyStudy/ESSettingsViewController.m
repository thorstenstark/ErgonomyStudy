//
//  ESSettingsViewController.m
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 20.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESSettingsViewController.h"
#import "ESAppDelegate.h"
#import "DataManager.h"

@interface ESSettingsViewController ()

@end

@implementation ESSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
	// Do any additional setup after loading the view.
    ESAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [self setSegmentedControl:_longSideTargetsControl toSegmentTitle:[NSString stringWithFormat:@"%.0f", delegate.numberHorizontalTargets ]];
    [self setSegmentedControl:_shortSideTargetsControl toSegmentTitle:[NSString stringWithFormat:@"%.0f", delegate.numberVertivalTargets]];
    [self setSegmentedControl:_sectionsControl toSegmentTitle:[NSString stringWithFormat:@"%.0f", delegate.numberHorizontalSections*delegate.numberVerticalSections]];
    DataManager *dataManager = [DataManager sharedManager] ;
    if (dataManager.numberOfIterationsPerBlock == 3){
        [_testSwitch setOn:YES animated:NO];
    } else{
        [_testSwitch setOn:NO animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControlChanged:(id)sender {
    ESAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    UISegmentedControl *control = (UISegmentedControl *)sender;
    int number = [[control titleForSegmentAtIndex:(NSUInteger) control.selectedSegmentIndex] integerValue];
    if (control == _longSideTargetsControl){
        [delegate setNumberHorizontalTargets:number];
    } else if (control == _shortSideTargetsControl){
                  [delegate setNumberVertivalTargets:number];
    }  else if (control == _sectionsControl){
                        switch (number){
                            case 6:
                                [delegate setNumberHorizontalSections:3];
                                [delegate setNumberVerticalSections:2];
                                break;
                            case 8:
                                [delegate setNumberHorizontalSections:4];
                                [delegate setNumberVerticalSections:2];
                                break;
                            case 9:
                                [delegate setNumberHorizontalSections:3];
                                [delegate setNumberVerticalSections:3];
                                break;
                            case 12:
                                [delegate setNumberHorizontalSections:4];
                                [delegate setNumberVerticalSections:3];
                                break;
                        }
    }
}

- (IBAction)setTestRun:(id)sender {
    UISwitch *testSwitch = sender;
    DataManager *dataManager = [DataManager sharedManager] ;
    if (testSwitch.on){

        dataManager.numberOfIterationsPerBlock = 3;
    } else{
        dataManager.numberOfIterationsPerBlock = 20;
    }
}

-(IBAction)deleteAllData:(id)sender{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Alle Daten löschen?" message:@"Sind Sie sicher, dass Sie alle Daten aus der Datenbank endgültig entfernen möchten? Bereits erstelle CSV Dateien bleiben dabei bestehen." delegate:self cancelButtonTitle:@"Abbrechen" otherButtonTitles:@"Löschen",nil];
    [self.alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex){
        case 0:
            break;
        case 1:
            NSLog(@"Löschen...");
            [[DataManager sharedManager] clearData];
            break;
        default:
            break;
    }
}

-(void)setSegmentedControl:(UISegmentedControl *)control toSegmentTitle:(NSString *)title {
    for (int i = 0; i < control.numberOfSegments; i++) {
           if ([[control titleForSegmentAtIndex:i] isEqualToString:title]){
               [control setSelectedSegmentIndex:i];
               return;
           }
    }
}
@end
