//
//  ESTouchTargetView.m
//  ErgonomyStudy
//
//  Created by Thorsten on 19.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESTouchTargetView.h"

@implementation ESTouchTargetView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithSize:(CGFloat)size {
    self = ([super initWithFrame:CGRectMake(0, 0, size, size)]);
    if (self) {
        _isHighlighted = NO;
        //self.backgroundColor = [UIColor whiteColor] ;
        [self setNeedsDisplay];

    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextClearRect(context, rect);



    //CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    if (self.isHighlighted) {
        CGContextSetFillColorWithColor(context, [_targetColor CGColor]);
    } else {
        if (!self.isActive){
            CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite:0.2 alpha:1.0] CGColor]);
        } else{
            CGContextSetFillColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
        }
    }

    CGContextSetLineWidth(context, 5.0);
    CGContextSetLineCap(context, kCGLineCapRound);


    //CGContextMoveToPoint(context, 0.0, 0.0);

    CGContextFillEllipseInRect(context, rect);
}

- (void)unhighlightTarget {   // remove color, but leave selectable
    self.isHighlighted = NO;
    [self setNeedsDisplay];
}

-(void)resetTarget {       // remove color and selection (reset to initial state)
    self.isHighlighted = NO;
    self.reactsOnTouch = NO;
    self.isActive = YES;
    [self setNeedsDisplay];
}

- (void)highlightTarget {       // add color and make selectable
    self.isHighlighted = YES;
    self.reactsOnTouch = YES;
    [self setNeedsDisplay];
}

- (void)deactivateTarget {        // show no interaction possible
    self.isActive = NO;
    self.isHighlighted = NO;
    [self setNeedsDisplay];
}

@end
