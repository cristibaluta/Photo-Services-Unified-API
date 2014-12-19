//
//  LIBAlbum.m
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "LIBAlbum.h"

@interface LIBAlbum ()
@end

@implementation LIBAlbum

- (instancetype)initWithAssetGroup:(ALAssetsGroup *)groupRef {
	self = [super init];
	if (self) {
		_groupRef = groupRef;
	}
	return self;
}

- (void)preloadCoverImage {
	
	// This is already loaded
    if (self.coverImage != nil) {
        [self dispatchLoadComplete];
    }
}


@end
