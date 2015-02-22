//
//  PhotoButton.m
//  InstaSlide
//
//  Created by Baluta Cristian on 10/04/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "ISCollectionCell.h"

@implementation ISCollectionCell
@synthesize imageView, markImage;

- (id)initWithFrame:(CGRect)frame {
	//RCLog(@"create new cell");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		imageView.contentMode  = UIViewContentModeScaleAspectFill;
		imageView.clipsToBounds = YES;
		[self addSubview:imageView];
		
		markImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 16, 16)];
		markImage.image = [UIImage imageNamed:@"Checkmark"];
		[self addSubview:markImage];
    }
    return self;
}

- (void)select:(BOOL)sel {
	
	[UIView beginAnimations:@"blue" context:NULL];
	[UIView setAnimationDuration:0.2];
	markImage.alpha = sel ? 1 : 0;
	imageView.alpha = sel ? 1 : 0.4;
	[UIView commitAnimations];
}


- (void) dealloc {
	
	[imageView removeFromSuperview];
	imageView = nil;
	[markImage removeFromSuperview];
	markImage = nil;
}


@end
