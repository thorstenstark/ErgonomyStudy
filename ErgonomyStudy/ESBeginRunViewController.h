//
//  ESBeginRunViewController.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 11.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESBeginRunViewController : UIViewController   <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *sequenceLabel;
@property(nonatomic, strong) UIAlertView *alertView;
@end
