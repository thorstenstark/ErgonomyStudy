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
#import "ESRunViewController.h"
#import "Touch.h"
#import "DataManager.h"

#define  TARGET_DISPLAY_TIME  1.0
#define  BREAK_DELAY  1.0


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
    int maxIterationsPerBlock;
    BOOL isShowingTargets;
    int iterationCount;
    BOOL wasTargetTouched;
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
    
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTouch:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];

    self.dataManager = [DataManager sharedManager] ;
}

- (void)didPressLong:(id)sender {
    if (!_alertView){
        _alertView = [[UIAlertView alloc] initWithTitle:@"Durchgang beenden?" message:@"Sind Sie mit diesem Durchgang fertig?" delegate:self cancelButtonTitle:@"Nein" otherButtonTitles:@"Ja",nil];
        [_alertView show];
    }
}

-(void)didTouch:(id)sender{
    UITapGestureRecognizer* tapGestureRecognizer = (UITapGestureRecognizer*)sender;
    CGPoint p = [tapGestureRecognizer locationInView:self.view];
    [self addFalseTouchAtPoint:p];
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
    maxIterationsPerBlock = _dataManager.numberOfIterationsPerBlock; // TODO: set to 20 for real test!!
    iterationCount = 0;
    
    //if (UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation])){
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
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
    CGFloat border = 40;  // Distances from screen border
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
            [targetView setTargetColor:_targetColor];
            [targetView setCenter:CGPointMake(i*xDistance+border, j*yDistance+border)];
            [self.view addSubview:targetView];
            [tmp addObject:targetView];
        }
        [self.buttonGrid addObject:tmp];
    }

    [self prepareNextIteration];
    
}

-(void)prepareNextIteration{
       if (iterationCount==maxIterationsPerBlock){
           [self blockIsOver];
           return;
       }
    [self resetAllTargets];
    [self highlightTargetsInSections];
    iterationCount++;

}

- (void)highlightTargetsInSections {
    int numberOfSections = (int) floorf(_xSectors * _ySectors);
    for (int i = 0; i < numberOfSections; i++) {
              NSArray *section = [self objectsInSection:i];
        int randomItemIndexInSection = (arc4random()%(int)(section.count))   ;
        ESTouchTargetView *targetView = [section objectAtIndex:randomItemIndexInSection];
        [targetView highlightTarget];
    }
}

-(void)unhighlightAllTargets {                     // unhighlight if no target was hit correctly
    for (NSArray *array  in self.buttonGrid) {
        for (ESTouchTargetView *targetView in array) {
            [targetView unhighlightTarget];
        }

    }

}

-(void)deactivateAllTargets {                // deactivate, if target was correctly hit
    for (NSArray *array  in self.buttonGrid) {
        for (ESTouchTargetView *targetView in array) {
            [targetView deactivateTarget];
        }

    }

}
                                              // reset to start new iteration
-(void)resetAllTargets {
    for (NSArray *array  in self.buttonGrid) {
        for (ESTouchTargetView *targetView in array) {
            [targetView resetTarget];
        }
        
    }
}

-(NSArray *)objectsInSection:(int)sectionNumber{
    int xSectorSize = (int) floorf(_xNums/ _xSectors);
    int ySectorSize = (int) floorf(_yNums/ _ySectors);
    int xFactor =   sectionNumber % (int)_xSectors;         //get column size
    int yFactor = (int) floor(sectionNumber/_xSectors);     // get row size
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
    if (wasTargetTouched){
         return;
    } else{
    ESTouchTargetView *touchTargetView = (ESTouchTargetView *)targetTouched.view;
    if (touchTargetView.reactsOnTouch){
        _timer?[self stopTimer]: nil;
        _breaktimer?[self stopBreakTimer]: nil;
        isShowingTargets = NO;
        [self deactivateAllTargets];
        [self addTargetTouchAtPoint:[targetTouched locationInView:self.view]];
        _dataManager.currentIteration.targetx = [NSNumber numberWithFloat:touchTargetView.center.x];
        _dataManager.currentIteration.targety = [NSNumber numberWithFloat:touchTargetView.center.y];

        [self startBreakTimer];



    }else{
        [self addFalseTouchAtPoint:[targetTouched locationInView:self.view]];
    }
    }

}

-(void)addFalseTouchAtPoint:(CGPoint)point{
    NSLog(@"False touch: %f, %f", point.x, point.y);
    Touch *touch = [_dataManager touchForCurrentIteration];
    touch.touchx = [NSNumber numberWithFloat:point.x];
    touch.touchy = [NSNumber numberWithFloat:point.y];
    touch.isTargetTouch = [NSNumber numberWithBool:NO];
}

-(void)addTargetTouchAtPoint:(CGPoint)point{
    NSLog(@"Hit: %f, %f", point.x, point.y);
    Touch *touch = [_dataManager touchForCurrentIteration];
    touch.touchx = [NSNumber numberWithFloat:point.x];
    touch.touchy = [NSNumber numberWithFloat:point.y];
    touch.isTargetTouch = [NSNumber numberWithBool:YES];
    wasTargetTouched = YES;
}

#pragma mark Timer

/*
   Target Timer
 */
-(void)startTimer{
    wasTargetTouched = NO;
    Iteration *iteration=[_dataManager createNewIteration];
    iteration.targetsize = [NSNumber numberWithInt:44];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TARGET_DISPLAY_TIME
                                                  target:self
                                                selector:@selector(timerTick:)
                                                userInfo:nil
                                                 repeats:NO];
    NSLog(@"TimerStart: %@", [[NSDate date] description]);
}

-(void)stopTimer{
    NSLog(@"TimerStop: %@", [[NSDate date] description]);
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerTick:(id)timerTick {
    NSLog(@"TimerTick: %@", [[NSDate date] description]);
    [self unhighlightAllTargets];
        [self stopTimer];
    _dataManager.currentIteration.disappearTime = [NSDate date];
    [self startBreakTimer];
}

/*
   Break Timer
 */
-(void)startBreakTimer{
    self.breaktimer = [NSTimer scheduledTimerWithTimeInterval:BREAK_DELAY
                                                  target:self
                                                selector:@selector(breakTick:)
                                                userInfo:nil
                                                 repeats:NO];
    NSLog(@"BreakTimerStart: %@", [[NSDate date] description]);
}

- (void)breakTick:(id)breakTick {
    NSLog(@"BreakTimerTick: %@", [[NSDate date] description]);
    [self stopBreakTimer];

    isShowingTargets = YES;
    if (iterationCount<maxIterationsPerBlock){
        [self startTimer];
        [self prepareNextIteration];
    } else{
        [self blockIsOver];
    }
}

-(void)stopBreakTimer{
    NSLog(@"BreakTimerStop: %@", [[NSDate date] description]);
    [self.breaktimer invalidate];
    self.breaktimer = nil;
}

#pragma mark - Block ending
-(void)blockIsOver{
    [self stopBreakTimer];
    [self stopTimer];
    [self.delegate blockIsOver];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
