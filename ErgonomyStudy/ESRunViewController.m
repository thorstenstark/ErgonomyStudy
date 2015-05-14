//
//  ESRunViewController.m
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 04.03.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESRunViewController.h"
#import "ESTouchTestViewController.h"
#import "DataManager.h"

@interface ESRunViewController ()

@end

@implementation ESRunViewController {
    NSArray *colors;
    int _usage;
    int _orientation;
    NSArray * _instructions;
    NSArray *_colorNames;
    int blockGroup;
    BOOL isMainBlock;
    NSString *_mainInstructionTextTemplate;
    NSString *_betweenInstructiontextTemplate;
    NSString *_mainInstructionGeneral;
    NSString *_mainInstructionBothHandsPortrait;
    NSString *_mainInstructionBothHandsLandscape;
    NSString *_mainInstructionSingleHandPortrait;
    NSString *_mainInstructionSingleHandLandscape;
    NSString *_greetingsText;
    NSString *_greetingsEndText;
    NSString *_changeHoldingText;
    NSString *_betweenInstructiontextTemplateOrange;
    NSString *_mainInstructionSingleHandLandscapeHTML;
    NSString *_mainInstructionSingleHandPortraitHTML;
    NSString *_mainInstructionBothHandsLandscapeHTML;
    NSString *_mainInstructionBothHandsPortraitHTML;
    NSString *_changeHoldingHTML;
    NSString *_greetingsEndHTML;
    NSString *_greetingsHTML;
    NSString *_mainInstructionTextTemplateHTML;
    NSString *_beginHTML;
    NSString *_endHTML;
    NSString *_betweenInstructiontextTemplateHTML;
    NSString *_betweenInstructiontextTemplateOrangeHTML;

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
    [self.navigationController setNavigationBarHidden:YES];
	// Do any additional setup after loading the view.
    self.datamanager = [DataManager sharedManager] ;
    //[_datamanager createNewRun];
    [_instructionsView setHidden:YES];
    [_closeRunView setHidden:YES];

    [self prepareRun];
}

-(void)viewWillAppear:(BOOL)animated {

}

- (void)prepareRun {
    _currentBlock = 0;
    _orientation = 0;
    _usage = 0;

    blockGroup = (int)floorf(_currentBlock/5);
    isMainBlock = YES;
    colors = [NSArray arrayWithObjects:[UIColor redColor],[UIColor yellowColor],[UIColor colorWithRed:0.5 green:0.6 blue:1.0 alpha:1.0],[UIColor greenColor],[UIColor orangeColor],nil];
    _colorNames = [NSArray arrayWithObjects:@"rot",@"gelb", @"blau", @"grün",  @"orange", nil];
    _greetingsText = @"Willkommen und vielen Dank für die Teilnahme!\n"
            "\n";
    _greetingsEndText = @"\nViel Spaß!";
    _changeHoldingText = @"Ändern Sie die Haltung!\n";
    
    _mainInstructionBothHandsPortrait = @"Im folgenden Experiment sollen Sie einen Tablet-PC bedienen. Dazu nehmen Sie den Tablet-PC im Hochformat in beide Hände, so dass Sie es mit beiden Händen bedienen können.\n\n"
            "Auf dem Bildschirm erscheinen grauen Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks rot.\n"
            "Drücken Sie so schnell wie möglich auf eine der roten Scheiben. Sie sollen nur eine rote Scheibe treffen. Achten Sie darauf, diese eine rote Scheibe so genau wie möglich zu treffen.  Es kommt darauf an, dass Sie EINE rote Scheibe berühren, welche ist dabei egal. \n";
            "Achten Sie darauf, dass Sie das Tablet durchweg im Hochformat halten und mit beiden Daumen bedienen.";
    _mainInstructionBothHandsLandscape = @"Im folgenden Experiment sollen Sie ein Tablet-PC bedienen. Dazu nehmen Sie den Tablet-PC im Querformat in beide Hände, so dass Sie es mit beiden Händen bedienen können.\n\n"
            "Auf dem Bildschirm erscheinen grauen Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks rot.\n"
            "Drücken Sie so schnell wie möglich auf eine der roten Scheiben. Sie sollen nur eine rote Scheibe treffen. Achten Sie darauf, diese eine rote Scheibe so genau wie möglich zu treffen.  Es kommt darauf an, dass Sie EINE rote Scheibe berühren, welche ist dabei egal. \n";
            "Achten Sie darauf, dass Sie das Tablet durchweg im Querformat halten und mit beiden Daumen bedienen.\n";

    _mainInstructionSingleHandPortrait = @"Im folgenden Experiment sollen Sie ein Tablet-PC bedienen. Dazu nehmen Sie den Tablet-PC im Hochformat in die Hände. Legen Sie das Tablet auf eine Hand und bedienen Sie es mit der anderen Hand (ihre Schreibhand). \n\n"
            "Auf dem Bildschirm erscheinen grauen Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks rot.\n"
            "Drücken Sie so schnell wie möglich auf eine der roten Scheiben. Sie sollen nur eine rote Scheibe treffen. Achten Sie darauf, diese eine rote Scheibe so genau wie möglich zu treffen.  Es kommt darauf an, dass Sie EINE rote Scheibe berühren, welche ist dabei egal. \n";
            "Achten Sie darauf, dass Sie das Tablet durchweg im Hochformat halten und mit einer Hand bedienen.\n";
    _mainInstructionSingleHandLandscape = @"Im folgenden Experiment sollen Sie ein Tablet-PC bedienen. Dazu nehmen Sie den Tablet-PC im Querformat in die Hände. Legen Sie das Tablet auf eine Hand und bedienen Sie es mit der anderen Hand (ihre Schreibhand). \n\n"
            "Auf dem Bildschirm erscheinen grauen Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks rot.\n"
            "Drücken Sie so schnell wie möglich auf eine der roten Scheiben. Sie sollen nur eine rote Scheibe treffen. Achten Sie darauf, diese eine rote Scheibe so genau wie möglich zu treffen.  Es kommt darauf an, dass Sie EINE rote Scheibe berühren, welche ist dabei egal. \n";
            "Achten Sie darauf, dass Sie das Tablet durchweg im Querformat halten und mit einer Hand bedienen.\n";

    _betweenInstructiontextTemplate = @"Gleich geht’s weiter!\n\n"
            "Behalten Sie das Format und die Griffhaltung des Tablets im nächsten Block bei. \n\n"
            "Auf dem Bildschirm erscheinen weiterhin graue Scheiben. Einige Scheiben werden in jeden Durchgang des folgenden Experimentalblocks nun aber CCC.\n"
            "Drücken Sie so schnell wie möglich auf eine der CCCen Scheiben. Sie sollen nur eine CCCe Scheibe treffen. Achten Sie darauf, diese eine CCCe Scheibe so genau wie möglich zu treffen. Es kommt darauf an, dass Sie EINE CCCe Scheibe berühren, welche ist dabei egal. \n"
            "Achten Sie darauf, dass Sie die Ausrichtung und die Griffhaltung des Tablet durchweg beibehalten.";
    _betweenInstructiontextTemplateOrange = @"Gleich geht’s weiter!\n\n"
            "Behalten Sie das Format und die Griffhaltung des Tablets im nächsten Block bei. \n\n"
            "Auf dem Bildschirm erscheinen weiterhin graue Scheiben. Einige Scheiben werden in jeden Durchgang des folgenden Experimentalblocks nun aber orange.\n"
            "Drücken Sie so schnell wie möglich auf eine der CCCen Scheiben. Sie sollen nur eine orangene Scheibe treffen. Achten Sie darauf, diese eine orangene Scheibe so genau wie möglich zu treffen. Es kommt darauf an, dass Sie EINE orangene Scheibe berühren, welche ist dabei egal. \n"
            "Achten Sie darauf, dass Sie die Ausrichtung und die Griffhaltung des Tablet durchweg beibehalten.";
    
    /*
    HTML Text
     */
    _beginHTML = @"<html><style>body{font-family:\"Helvetica Neue\", Helvetica;font-size:17px;font-weight:default;}</style><body >";
    _endHTML = @"</body></html>";
    _greetingsHTML = @"<p><h2>Willkommen und vielen Dank für die Teilnahme!</h2></p><br>\n"
            "\n";
    _greetingsEndHTML = @"\n<br>Viel Spaß!";
    _changeHoldingHTML = @"<h2>Ändern Sie nun die Haltung!</h2><br>\n";

    _mainInstructionBothHandsPortraitHTML = @"Im folgenden Experiment sollen Sie einen Tablet-PC bedienen. Dazu nehmen Sie den Tablet-PC im <b>Hochformat</b> in beide Hände, so dass Sie es mit <b>beiden Händen</b> bedienen können.<br>\n\n"
            "Auf dem Bildschirm erscheinen grauen Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks <b>rot</b>.<br><br>\n"
            "Drücken Sie so schnell wie möglich auf eine der roten Scheiben. Sie sollen nur eine rote Scheibe treffen. Achten Sie darauf, diese eine rote Scheibe so genau wie möglich zu treffen.  Es kommt darauf an, dass Sie <b>EINE rote Scheibe</b> berühren, welche ist dabei egal. <br><br>\n"
    "Achten Sie darauf, dass Sie das Tablet durchweg im Hochformat halten und mit beiden Daumen bedienen.<br>";
    _mainInstructionBothHandsLandscapeHTML = @"Im folgenden Experiment sollen Sie ein Tablet-PC bedienen. Dazu nehmen Sie den Tablet-PC im <b>Querformat</b> in beide Hände, so dass Sie es mit <b>beiden Händen</b> bedienen können.<br>\n\n"
            "Auf dem Bildschirm erscheinen grauen Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks <b>rot</b>.<br><br>\n"
            "Drücken Sie so schnell wie möglich auf eine der roten Scheiben. Sie sollen nur eine rote Scheibe treffen. Achten Sie darauf, diese eine rote Scheibe so genau wie möglich zu treffen.  Es kommt darauf an, dass Sie <b>EINE rote Scheibe</b> berühren, welche ist dabei egal.<br><br> \n"
    "Achten Sie darauf, dass Sie das Tablet durchweg im Querformat halten und mit beiden Daumen bedienen.\n";

    _mainInstructionSingleHandPortraitHTML = @"Im folgenden Experiment sollen Sie ein Tablet-PC bedienen. Dazu nehmen Sie den Tablet-PC im <b>Hochformat</b> in die Hände. Legen Sie das Tablet auf <b>eine Hand</b> und bedienen Sie es mit der anderen Hand (ihre Schreibhand).<br><br> \n\n"
            "Auf dem Bildschirm erscheinen grauen Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks <b>rot</b>.<br><br>\n"
            "Drücken Sie so schnell wie möglich auf eine der roten Scheiben. Sie sollen nur eine rote Scheibe treffen. Achten Sie darauf, diese eine rote Scheibe so genau wie möglich zu treffen.  Es kommt darauf an, dass Sie <b>EINE rote Scheibe</b> berühren, welche ist dabei egal. <br><br>\n"
    "Achten Sie darauf, dass Sie das Tablet durchweg im Hochformat halten und mit einer Hand bedienen.<br>\n";
    _mainInstructionSingleHandLandscapeHTML = @"Im folgenden Experiment sollen Sie ein Tablet-PC bedienen. Dazu nehmen Sie den Tablet-PC im <b>Querformat</b> in die Hände. Legen Sie das Tablet auf <b>eine Hand</b> und bedienen Sie es mit der anderen Hand (ihre Schreibhand). <br>\n\n"
            "Auf dem Bildschirm erscheinen grauen Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks <b>rot</b>.<br><br>\n"
            "Drücken Sie so schnell wie möglich auf eine der roten Scheiben. Sie sollen nur eine rote Scheibe treffen. Achten Sie darauf, diese eine rote Scheibe so genau wie möglich zu treffen.  Es kommt darauf an, dass Sie <b>EINE rote Scheibe</b> berühren, welche ist dabei egal.<br><br> \n"
    "Achten Sie darauf, dass Sie das Tablet durchweg im Querformat halten und mit einer Hand bedienen.\n";

    _betweenInstructiontextTemplateHTML = [NSString stringWithFormat:@"%@<h3>Gleich geht’s weiter!</h3><br>\n\n"
            "<b>Behalten Sie das Format und die Griffhaltung des Tablets im nächsten Block bei. </b><br><br>\n\n"
            "Auf dem Bildschirm erscheinen weiterhin graue Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks nun aber <b>CCC</b>.<br><br>\n"
            "Drücken Sie so schnell wie möglich auf eine der CCCen Scheiben. Sie sollen nur eine CCCe Scheibe treffen. Achten Sie darauf, diese eine CCCe Scheibe so genau wie möglich zu treffen. Es kommt darauf an, dass Sie <b>EINE CCCe Scheibe</b> berühren, welche ist dabei egal. <br>\n"
            "Achten Sie darauf, dass Sie die Ausrichtung und die Griffhaltung des Tablet durchweg beibehalten.<br>%@",_beginHTML,_endHTML];
    _betweenInstructiontextTemplateOrangeHTML = [NSString stringWithFormat:@"%@<h3>Gleich geht’s weiter!</h3><br>\n\n"
            "<b>Behalten Sie das Format und die Griffhaltung des Tablets im nächsten Block bei.</b> <br><br>\n\n"
            "Auf dem Bildschirm erscheinen weiterhin graue Scheiben. Einige Scheiben werden in jedem Durchgang des folgenden Experimentalblocks nun aber <b>orange</b>.<br><br>\n"
            "Drücken Sie so schnell wie möglich auf eine der orangenen Scheiben. Sie sollen nur eine orangene Scheibe treffen. Achten Sie darauf, diese eine orangene Scheibe so genau wie möglich zu treffen. Es kommt darauf an, dass Sie <b>EINE orangene Scheibe</b> berühren, welche ist dabei egal. <br>\n"
            "Achten Sie darauf, dass Sie die Ausrichtung und die Griffhaltung des Tablet durchweg beibehalten.%@",_beginHTML,_endHTML];
    [self updateInstructions];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    BOOL allowSegue = [self isCorrectInterfaceOrientation];
    if (!allowSegue){
        self.alertView = [[UIAlertView alloc] initWithTitle:@"Falsche Ausrichtung" message:@"Bitte halten Sie das Tablet entsprechend der Anweisung." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.alertView show];
    }
    return  allowSegue;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    ESTouchTestViewController *touchTestViewController = (ESTouchTestViewController *)segue.destinationViewController;
    [touchTestViewController setTargetColor:[colors objectAtIndex:[self colorPosition]]];
    touchTestViewController.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return YES;
}

-(BOOL)isCorrectInterfaceOrientation{
    int isPortrait = 1;
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
           isPortrait = 0;
    }

    return _orientation == isPortrait;

}

-(BOOL)runWillBeOver{
    if (_currentBlock>=20){
        [_instructionsView setHidden:YES];
        [_mainInstructionsView setHidden:YES];
        [_closeRunView setHidden:NO];
        return YES;
    } else{
        return NO;
    }
}

- (void)blockIsOver {
          _currentBlock++;
    if ([self runWillBeOver]){

        return;
    }

    int newBlockGroup = (int)floorf(_currentBlock /5);   // blockgroup is used to determine which combination of usage and orientation to use
    if (newBlockGroup!= blockGroup){                     // if blockgroup changes another description text should be shown
        blockGroup = newBlockGroup;
        isMainBlock = YES;
    }   else{
        isMainBlock = NO;
    }
    NSLog(@"NweBlockGroup: %d - blockGroup: %d", newBlockGroup, blockGroup);
    [self updateInstructions];
}


- (void)updateInstructions {

    int blockConfigNumber = [_datamanager numberForBlockConfigurationAtBlock:blockGroup];
    NSLog(@"BlockConfigNumber: %d", blockConfigNumber);

    switch (blockConfigNumber) {
        case 0:   // single hand  + portrait
            _usage = 0;
            _orientation = 0;
            _mainInstructionTextTemplate = _mainInstructionSingleHandPortrait;
            _mainInstructionTextTemplateHTML = _mainInstructionSingleHandPortraitHTML;
            _mainInstructionsImageView.image = [UIImage imageNamed:@"one-finger-holding-right-portrait.png"];
            _instructionsImageView.image = [UIImage imageNamed:@"one-finger-holding-right-portrait.png"];
            break;
        case 1:       // both hands + portrait
            _usage = 1;
            _orientation = 0;
            _mainInstructionTextTemplate = _mainInstructionBothHandsPortrait;
            _mainInstructionTextTemplateHTML = _mainInstructionBothHandsPortraitHTML;
            _mainInstructionsImageView.image = [UIImage imageNamed:@"thumb-portrait-right-usage.png"];
            _instructionsImageView.image = [UIImage imageNamed:@"thumb-portrait-right-usage.png"];
            break;
        case 2:   // single hand + landscape
            _usage = 0;
            _orientation = 1;
            _mainInstructionTextTemplate = _mainInstructionSingleHandLandscape;
            _mainInstructionTextTemplateHTML = _mainInstructionSingleHandLandscapeHTML;
            _mainInstructionsImageView.image = [UIImage imageNamed:@"one-finger-holding-right-landscape.png"];
            _instructionsImageView.image = [UIImage imageNamed:@"one-finger-holding-right-landscape.png"];
            break;
        case 3:   // both hands + landscape
            _usage = 1;
            _orientation = 1;
            _mainInstructionTextTemplate = _mainInstructionBothHandsLandscape;
            _mainInstructionTextTemplateHTML = _mainInstructionBothHandsLandscapeHTML;
            _mainInstructionsImageView.image = [UIImage imageNamed:@"thumb-right-usage.png"];
            _instructionsImageView.image = [UIImage imageNamed:@"thumb-right-usage.png"];
            break;
        default:     // default value shouldn't be called...
            _usage = 0;
            _orientation = 0;
            break;
    }
    if (blockGroup == 0) {
        _mainInstructionTextTemplate = [NSString stringWithFormat:@"%@%@%@", _greetingsText, _mainInstructionTextTemplate, _greetingsEndText];
        _mainInstructionTextTemplateHTML = [NSString stringWithFormat:@"%@%@%@%@%@", _beginHTML, _greetingsHTML, _mainInstructionTextTemplateHTML, _greetingsEndHTML, _endHTML];
    } else {
        _mainInstructionTextTemplate = [_changeHoldingText stringByAppendingString:_mainInstructionTextTemplate];
        _mainInstructionTextTemplateHTML = [NSString stringWithFormat:@"%@%@%@%@", _beginHTML, _changeHoldingHTML, _mainInstructionTextTemplateHTML, _endHTML];
    }
    Block *block = [_datamanager createNewBlockWithNumber:_currentBlock];
    block.usage = [NSNumber numberWithInt:_usage];
    block.orientation = [NSNumber numberWithInt:_orientation];
    block.color = [_colorNames objectAtIndex:[self colorPosition]];

    if (isMainBlock) {
        [_mainInstructionsView setHidden:NO];
        [_instructionsView setHidden:YES];

        [self.mainInstructionsWebView loadHTMLString:_mainInstructionTextTemplateHTML baseURL:nil];
    } else {
        [_mainInstructionsView setHidden:YES];
        [_instructionsView setHidden:NO];
        if ([block.color isEqualToString:@"orange"]) {
            [self.instructionsWebView loadHTMLString:_betweenInstructiontextTemplateOrangeHTML baseURL:nil];

        } else {
            [self.instructionsWebView loadHTMLString:[_betweenInstructiontextTemplateHTML stringByReplacingOccurrencesOfString:@"CCC" withString:block.color] baseURL:nil];

        }

    }

}


- (int)colorPosition {

    /*if (_orientation == 0 && _usage == 0) {
        return _currentBlock;
    } else {
     */
    int colorPos = _currentBlock % 5;
    return colorPos;
    //}
}

#pragma mark - Abort Run

-(IBAction)userWantsToAbort:(id)sender{
    //if (!self.alertView){
        self.alertView = [[UIAlertView alloc] initWithTitle:@"Test beenden?" message:@"Wollen Sie den Test wirklich abbrechen?" delegate:self cancelButtonTitle:@"Nein" otherButtonTitles:@"Ja",nil];
        [self.alertView show];
    //}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex){
        case 0:    // continue...
            break;
        case 1:   // abort run
            [_datamanager removeRunIfEmpty]; // delete the run if there was no data collected
            [self endRun];
            break;
        default:
            break;
    }
}

-(IBAction)endRunPressed{
    [self endRun];
}

- (void)endRun {
    NSLog(@"Das war's.");
    [_datamanager endRun];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
