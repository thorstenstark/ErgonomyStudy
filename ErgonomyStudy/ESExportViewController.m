//
//  ESExportViewController.m
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 07.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESExportViewController.h"
#import "DataManager.h"
#import "SimpleButton.h"

@interface ESExportViewController ()

@end

@implementation ESExportViewController {
    dispatch_queue_t backgroundQueue;
}

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
    backgroundQueue = dispatch_queue_create("com.beuth-hochschule.momo", NULL);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createCSV:(id)sender {
    _textView.text = @"Erstelle CSV ...";
    dispatch_async(backgroundQueue, ^(void){
        DataManager *dataManager = [DataManager sharedManager] ;
        NSString *csvString = [dataManager exportCSV];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            _textView.text = csvString;
        });


    })  ;

}

@end
