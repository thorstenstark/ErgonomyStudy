//
//  ESSettingsViewController.m
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 20.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESSettingsViewController.h"
#import "ESAppDelegate.h"

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
	// Do any additional setup after loading the view.
    ESAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [self setSegmentedControl:_longSideTargetsControl toSegmentTitle:[NSString stringWithFormat:@"%.0f", delegate.numberHorizontalTargets ]];
    [self setSegmentedControl:_shortSideTargetsControl toSegmentTitle:[NSString stringWithFormat:@"%.0f", delegate.numberVertivalTargets]];
    [self setSegmentedControl:_sectionsControl toSegmentTitle:[NSString stringWithFormat:@"%.0f", delegate.numberHorizontalSections*delegate.numberVerticalSections]];
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

-(void)setSegmentedControl:(UISegmentedControl *)control toSegmentTitle:(NSString *)title {
    for (int i = 0; i < control.numberOfSegments; i++) {
           if ([[control titleForSegmentAtIndex:i] isEqualToString:title]){
               [control setSelectedSegmentIndex:i];
               return;
           }
    }
}
@end
