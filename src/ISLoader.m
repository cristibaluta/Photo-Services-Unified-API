//
//  LIBPhotosManager.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "ISLoader.h"

@implementation ISLoader

- (id) init {
	self = [super init];
	if (self) {
		_albums = [[NSMutableArray alloc] init];
		_photos = [[NSMutableArray alloc] init];
	}
	return self;
}

// Override this methods

- (void) requestAlbums {
	
}
- (void) requestPhotosForAlbumId:(NSString*)albumId {
	
}
- (void) cancel {
	
}


@end
