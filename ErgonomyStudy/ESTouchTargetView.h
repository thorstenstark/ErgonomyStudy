//
//  ESTouchTargetView.h
//  ErgonomyStudy
//
//  Created by Thorsten on 19.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESTouchTargetView : UIView

@property(nonatomic) BOOL isHighlighted;
@property (nonatomic) BOOL reactsOnTouch;

@property(nonatomic, strong) UIColor * targetColor;

@property(nonatomic) BOOL isActive;

- (id)initWithSize:(CGFloat)size;

- (void)unhighlightTarget;

- (void)highlightTarget;

- (void)resetTarget;

- (void)deactivateTarget;
@end
