//
//  ESBackgroundView.m
//  ErgonomyStudy
//
//  Created by Thorsten Stark on 28.02.14.
//  Copyright (c) 2014 Thorsten. All rights reserved.
//

#import "ESBackgroundView.h"

@implementation ESBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextClearRect(context, rect);

    CGContextSetFillColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [[UIColor darkGrayColor] CGColor])  ;

    int xLength = (int) floorf(1024/ _xSectors);
    int yLength = (int) floorf(1024/ _ySectors);

    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapRound);


    for (int i = 0; i < _xSectors; i++) {
        CGContextMoveToPoint(context, i*xLength, 0);
        CGContextAddLineToPoint(context, i*xLength, 768);
    }
    for (int i = 0; i < _ySectors; i++) {
        CGContextMoveToPoint(context, i*yLength, 0);
        CGContextAddLineToPoint(context, i*yLength, 768);
    }



    CGContextStrokePath(context);
    
    // Drawing code
}


@end
