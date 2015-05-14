//
//  ESExportViewController.h
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 07.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleButton;

@interface ESExportViewController : UIViewController
- (IBAction)createCSV:(id)sender;

@property (weak, nonatomic) IBOutlet SimpleButton *exportBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
