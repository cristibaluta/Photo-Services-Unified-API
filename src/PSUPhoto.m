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

- (void)preloadThumbImage{
	
}

- (void)preloadSourceImage{
	
}

- (void)dispatchLoadComplete {
	[self.delegate photoFinishedLoading:self];
}

@end
