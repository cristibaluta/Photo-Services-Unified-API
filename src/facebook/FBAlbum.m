//
//  FBAlbum.m
//  Instaslider
//
//  Created by Baluta Cristian on 14/04/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBAlbum.h"

@implementation FBAlbum


- (void)preloadCoverImage {
    
    if (self.coverImage != nil) {
        [self dispatchLoadComplete];
        return;
    }
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		
		NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.coverUrl];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			self.coverImage = [[UIImage alloc] initWithData:imageData];
			[self dispatchLoadComplete];
		});
	});
}


@end
