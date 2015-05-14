//
//  ESTouchTestViewController.m
//  ErgonomyStudy
//
//  Created by Thorsten on 19.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESTouchTestViewController.h"
#import "ESTouchTargetView.h"
#import "ESAppDelegate.h"

@interface ESTouchTestViewController ()

@end

@implementation ESTouchTestViewController {
    CGFloat _xNums;
    CGFloat _yNums;
    CGFloat _ySectors;
    CGFloat _xSectors;
    CGFloat numberTargetsLongSide;
    CGFloat numberTargetsShortSide;
    CGFloat numberSectionsLongSide;
    CGFloat numberSectionsShortSide;
    UIAlertView *_alertView;
    BOOL isShowingTargets;
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
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];

    //[self.view setBackgroundColor:[UIColor whiteColor]];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didPressLong:)];
    //[longPressGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:longPressGestureRecognizer];
}

- (void)didPressLong:(id)sender {
    if (!_alertView){
        _alertView = [[UIAlertView alloc] initWithTitle:@"Durchgang beenden?" message:@"Sind Sie mit diesem Durchgang fertig?" delegate:self cancelButtonTitle:@"Nein" otherButtonTitles:@"Ja",nil];
        [_alertView show];
    }
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex){
        case 0:
            break;
        case 1:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    ESAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    numberTargetsLongSide = delegate.numberHorizontalTargets;
    numberTargetsShortSide = delegate.numberVertivalTargets;
    numberSectionsLongSide = delegate.numberHorizontalSections;
    numberSectionsShortSide = delegate.numberVerticalSections;
    [self setupController];
}

-(void)viewDidAppear:(BOOL)animated {
    isShowingTargets = YES;
    [self startTimer];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self stopTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    return NO;
}

-(void)setupController{
    if (UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation])){
        _xNums = numberTargetsLongSide;
        _yNums = numberTargetsShortSide;
        _xSectors = numberSectionsLongSide;
        _ySectors = numberSectionsShortSide;
    } else{
        _xNums = numberTargetsShortSide;
        _yNums = numberTargetsLongSide;
        _ySectors = numberSectionsLongSide;
        _xSectors = numberSectionsShortSide;
    }
    //
    CGFloat border = 40;
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat xDistance = (screenWidth-border*2)/(_xNums -1);
    CGFloat yDistance = (screenHeight-border*2)/(_yNums -1);
    CGFloat size = 44;
    self.buttonGrid = [NSMutableArray new] ;
    for (int i = 0; i < _xNums; i++) {
        NSMutableArray *tmp = [NSMutableArray new];
        for (int j = 0; j < _yNums; j++) {
            ESTouchTargetView *targetView = [[ESTouchTargetView alloc] initWithSize:size];
            [targetView setCenter:CGPointMake(i*xDistance+border, j*yDistance+border)];
            [self.view addSubview:targetView];
            [tmp addObject:targetView];
        }
        [self.buttonGrid addObject:tmp];
    }

    [self prepareNextIteration];
    
}

-(void)prepareNextIteration{

    int numberOfSections = _xSectors * _ySectors;
    for (int i = 0; i < numberOfSections; i++) {
              NSArray *section = [self objectsInSection:i];
        int rand = (arc4random()%(int)(section.count))   ;
        ESTouchTargetView *targetView = [section objectAtIndex:rand];
        [targetView highlightTarget];
    }

}

-(void)deselectAllTargets{
    for (NSArray *array  in self.buttonGrid) {
        for (ESTouchTargetView *targetView in array) {
                [targetView deselectTarget];
        }

    }

}

-(NSArray *)objectsInSection:(int)sectionNumber{
    int xSectorSize = (int) floorf(_xNums/ _xSectors);
    int ySectorSize = (int) floorf(_yNums/ _ySectors);
    int xFactor =  sectionNumber%xSectorSize; //get column
    int yFactor = (int) floor(sectionNumber/_xSectors);
    NSMutableArray *tmp = [NSMutableArray new];
    for (int i = (xFactor*xSectorSize); i < ((xFactor+1)*xSectorSize); i++) {
        for (int j = (yFactor*ySectorSize); j< ((yFactor+1)*ySectorSize); j++) {
            ESTouchTargetView *targetView = [[_buttonGrid objectAtIndex:i] objectAtIndex:j]  ;
            [tmp addObject: targetView];
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(targetTouched:)];
            [targetView addGestureRecognizer:tapRecognizer];
        }
    }
    return tmp;
}

- (void)targetTouched:(UITapGestureRecognizer *)targetTouched {
    ESTouchTargetView *touchTargetView = (ESTouchTargetView *)targetTouched.view;
    if (touchTargetView.isActive){
        [self stopTimer];
        isShowingTargets = NO;
        [self deselectAllTargets];
        [self startBreakTimer];
    }

}

#pragma mark Timer

-(void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(timerTick:)
                                                userInfo:nil
                                                 repeats:YES];
}

-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerTick:(id)timerTick {
        [self deselectAllTargets];
        [self prepareNextIteration];
}

-(void)startBreakTimer{
    self.breaktimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                  target:self
                                                selector:@selector(breakTick:)
                                                userInfo:nil
                                                 repeats:NO];
}

- (void)breakTick:(id)breakTick {
    [self.breaktimer invalidate];
    self.breaktimer = nil;

    isShowingTargets = YES;
    [self startTimer];
    [self prepareNextIteration];
}

@end
