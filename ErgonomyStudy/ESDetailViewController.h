//
//  ESDetailViewController.h
//  ErgonomyStudy
//
//  Created by Thorsten on 19.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
