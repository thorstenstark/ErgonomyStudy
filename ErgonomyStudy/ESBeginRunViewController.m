//
//  ESBeginRunViewController.m
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 11.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESBeginRunViewController.h"
#import "DataManager.h"

@interface ESBeginRunViewController ()

@end

@implementation ESBeginRunViewController

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
    _sequenceLabel.text = [[DataManager sharedManager] calculateCurrentSequence];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (_userIDLabel.text.length >0){
        return YES;

    }
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Fehlende Eingabe" message:@"Bitte geben Sie Ihre Probandennummer ein." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [self.alertView show];
    return NO;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[DataManager sharedManager] createNewRunWithUserID:_userIDLabel.text];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];


    return YES;
}

@end
