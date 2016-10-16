//
//  FBPhoto.m
//  Instaslider
//
//  Created by Baluta Cristian on 14/04/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "PSUPhoto.h"

@implementation PSUPhoto

- (void)select:(BOOL)v {
	self.selected = v;
}

- (void)preloadThumbImage:(void(^)(PSUPhoto *))completionBlock {
	
}

- (void)preloadSourceImage {
	
}

- (void)dispatchLoadComplete {
    if (self.delegate != nil) {
        [self.delegate photoFinishedLoading:self];
    }
}

@end
