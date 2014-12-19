//
//  LIBAlbum.m
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "LIBAlbum.h"

@implementation LIBAlbum


// This is already loaded
- (void)preloadCoverImage {
	
    if (self.coverImage != nil) {
        [self dispatchLoadComplete];
    }
    
}


@end
