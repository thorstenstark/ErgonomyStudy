//
//  ESRunViewController.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 04.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataManager.h"

@interface ESRunViewController : UIViewController   <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *instructionsView;
@property (weak, nonatomic) IBOutlet UIWebView *instructionsWebView;
@property (weak, nonatomic) IBOutlet UIImageView *instructionsImageView;

@property (weak, nonatomic) IBOutlet UIView *mainInstructionsView;
@property (weak, nonatomic) IBOutlet UIWebView *mainInstructionsWebView;
@property (weak, nonatomic) IBOutlet UIImageView *mainInstructionsImageView;


@property (weak, nonatomic) IBOutlet UIView *closeRunView;

@property(nonatomic) int currentBlock;

@property(nonatomic, strong) DataManager *datamanager;

@property(nonatomic, strong) UIAlertView *alertView;

- (void)blockIsOver;

- (IBAction)endRunPressed;
@end
