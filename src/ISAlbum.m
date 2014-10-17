//
//  ISAlbum.m
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "ISAlbum.h"

@implementation ISAlbum

- (void) preloadCoverImage {
}

- (void) dispatchLoadComplete {
    if ([self.delegate respondsToSelector:@selector(loadFinishedForIndexPath:)])
        [self.delegate performSelector:@selector(loadFinishedForIndexPath:) withObject:self.indexPath];
}

@end
