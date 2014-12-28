//
//  LIBPhoto.m
//  Instaslider
//
//  Created by Baluta Cristian on 06/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "SIPhoto.h"

@implementation SIPhoto

- (void)preloadThumbImage {
	
    if (self.thumbImage == nil) {
		
		
	}
	else {
        [self dispatchLoadComplete];
    }
}
- (void)preloadSourceImage {
	
	NSLog(@"preloadSourceImage %@", self.sortedIndexPath);
	if (self.sourceImage == nil) {
		
		
	}
	else {
        [self dispatchLoadComplete];
    }
}


@end
