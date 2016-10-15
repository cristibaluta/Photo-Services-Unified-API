//
//  LIBPhotosManager.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSUAlbum.h"
#import "PSUPhoto.h"

@interface PSULoader : NSObject {
	NSMutableArray<PSUAlbum *> *_albums;
	NSMutableArray<PSUPhoto *> *_photos;
}

@property (nonatomic, readonly) NSArray<PSUAlbum *> *albums;
@property (nonatomic, readonly) NSArray<PSUPhoto *> *photos;

- (void)requestAlbums:(void(^)(NSArray<PSUAlbum *> *albums))block;
- (void)requestPhotosForAlbumId:(NSString *)albumId completion:(void(^)(NSArray<PSUPhoto *> *photos))block;
- (void)cancel;

@end
