//
//  LIBPhotosManager.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "PSULoader.h"

@interface PSULoader ()
@end

@implementation PSULoader

- (id) init {
	self = [super init];
	if (self) {
		_albums = [[NSMutableArray alloc] init];
		_photos = [[NSMutableArray alloc] init];
	}
	return self;
}

// Override this methods

- (void)requestAlbums {
	
}

- (void)requestPhotosForAlbumId:(NSString *)albumId {
	
}

- (void)cancel {
	
}

- (NSArray *)albums {
	return [NSArray arrayWithArray:_albums];
}

- (NSArray *)photos {
	return [NSArray arrayWithArray:_photos];
}


@end
