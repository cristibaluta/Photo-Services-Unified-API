//
//  LIBLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "NIFLoader.h"

@interface NIFLoader () {
	
	
}
@end

@implementation NIFLoader

- (id) init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)requestAlbums {
	NSLog(@"LIBLoader request albums");
    
}

- (void)requestPhotosForAlbumId:(NSString *)albumId {
	NSLog(@"LIBLoader request photos for album id %@", albumId);
    
}

- (void)cancel {
	// There's nothing to cancel when enumerating the groups
}



@end
