//
//  SimpleButton.m
//  UsabilityTester
//
//  Created by Thorsten Stark on 21.01.13.
//  Copyright (c) 2013 Thorsten Stark. All rights reserved.
//

#import "SimpleButton.h"

@implementation SimpleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
	self= [super initWithCoder:aDecoder];
	if (self) {
		[self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		[self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
