//
//  WebPhoto.m
//  Instaslider
//
//  Created by Baluta Cristian on 07/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "WebPhoto.h"

@implementation WebPhoto

- (void) preloadThumbImage{
	
    if (self.thumbImage == nil) {
		loadingThumb = YES;
		[NSThread detachNewThreadSelector:@selector(loadImageData:)
								 toTarget:self
							   withObject:self.thumbUrl];
	}
	else {
        [self dispatchLoadComplete];
    }
}
- (void) preloadSourceImage{
	
	if (self.sourceImage == nil) {
		loadingThumb = NO;
		[NSThread detachNewThreadSelector:@selector(loadImageData:)
								 toTarget:self
							   withObject:self.sourceUrl];
	}
	else {
        [self dispatchLoadComplete];
    }
}

- (void) loadImageData:(NSURL *)url {
	
	// Load image
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    
	[self performSelectorOnMainThread:@selector(cacheImage:)
						   withObject:imageData
						waitUntilDone:NO];
}

- (void) cacheImage:(NSData*)imageData {
	if (loadingThumb) {
		self.thumbImage = [[UIImage alloc] initWithData:imageData];
	}
	else {
		self.sourceImage = [[UIImage alloc] initWithData:imageData];
	}
    
    [self dispatchLoadComplete];
}

@end
