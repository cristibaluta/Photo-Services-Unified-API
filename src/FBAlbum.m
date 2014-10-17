//
//  FBAlbum.m
//  Instaslider
//
//  Created by Baluta Cristian on 14/04/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "FBAlbum.h"

@implementation FBAlbum


- (void) preloadCoverImage {
    
    if (self.coverImage != nil) {
        [self dispatchLoadComplete];
        return;
    }
    
    // Load image in a new thread
    [NSThread detachNewThreadSelector:@selector(loadImageData:)
							 toTarget:self
						   withObject:self.coverUrl];
}

- (void) loadImageData:(NSURL *)url {
	
	// Load image
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    
	[self performSelectorOnMainThread:@selector(cacheImage:)
						   withObject:imageData
						waitUntilDone:NO];
}

- (void) cacheImage:(NSData*)imageData {
    self.coverImage = [[UIImage alloc] initWithData:imageData];
    [self dispatchLoadComplete];
}


@end
