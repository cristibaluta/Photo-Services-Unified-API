//
//  PSUAlbum.m
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "PSUAlbum.h"

@implementation PSUAlbum

- (void)preloadCoverImage {
	assert("hs must be veden");
}

- (void)dispatchLoadComplete {
    if ([self.delegate respondsToSelector:@selector(loadFinishedForIndexPath:)])
        [self.delegate performSelector:@selector(loadFinishedForIndexPath:) withObject:self.indexPath];
}

@end
