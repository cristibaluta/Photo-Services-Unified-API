//
//  LIBPhotosManager.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSULoader : NSObject {
	NSMutableArray *_albums;// PSUAlbum objects
	NSMutableArray *_photos;
}

/*!
 PSUAlbum objects
 */
@property (nonatomic, readonly) NSArray *albums;

/*!
 PSUPhoto objects
 */
@property (nonatomic, readonly) NSArray *photos;

- (void)requestAlbums:(void(^)(NSArray *albums))block;
- (void)requestPhotosForAlbumId:(NSString *)albumId completion:(void(^)(NSArray *photos))block;
- (void)cancel;

@end
