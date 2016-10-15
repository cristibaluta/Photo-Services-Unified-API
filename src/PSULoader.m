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

- (void)requestAlbums:(void(^)(NSArray<PSUAlbum *> *albums))block {
    NSAssert(NO, @"Method must be implemented by subclass");
}

- (void)requestPhotosForAlbumId:(NSString *)albumId completion:(void(^)(NSArray<PSUPhoto *> *photos))block {
	NSAssert(NO, @"Method must be implemented by subclass");
}

- (void)cancel {
	NSAssert(NO, @"Method must be implemented by subclass");
}

- (NSArray<PSUAlbum *> *)albums {
	return [NSArray arrayWithArray:_albums];
}

- (NSArray<PSUPhoto *> *)photos {
	return [NSArray arrayWithArray:_photos];
}


@end
