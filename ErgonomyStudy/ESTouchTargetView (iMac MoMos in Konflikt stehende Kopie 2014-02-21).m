//
//  ESTouchTargetView.m
//  ErgonomyStudy
//
//  Created by Thorsten on 19.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESTouchTargetView.h"

@implementation ESTouchTargetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithSize:(CGFloat)size {
    self = ([super initWithFrame:CGRectMake(0, 0, size, size)]);
    if (self){
            _isActive = NO;
        //self.backgroundColor = [UIColor whiteColor] ;
        [self setNeedsDisplay];

    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextClearRect(context, rect);



    //CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    if (self.isActive){
        CGContextSetFillColor(context, CGColorGetComponents( [[UIColor blueColor] CGColor]));
    } else{
        CGContextSetFillColor(context, CGColorGetComponents( [[UIColor darkGrayColor] CGColor]));
    }

    CGContextSetLineWidth(context, 5.0);
    CGContextSetLineCap(context, kCGLineCapRound);


    //CGContextMoveToPoint(context, 0.0, 0.0);

    CGContextFillEllipseInRect(context, rect);
}

- (void)deselectTarget {
        self.isActive = NO;
    [self setNeedsDisplay];
}

- (void)highlightTarget {
         self.isActive = YES;
    [self setNeedsDisplay];
}
@end
