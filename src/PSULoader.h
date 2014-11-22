//
//  LIBPhotosManager.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PSULoaderDelegate <NSObject>

- (void)albumsLoaded:(NSArray *)albums;
- (void)photosLoaded:(NSArray *)albums;

@end

@interface PSULoader : NSObject {
	NSMutableArray *_albums;// PSUAlbum objects
	NSMutableArray *_photos;
}

@property (nonatomic, weak) id<PSULoaderDelegate> delegate;

/*!
 PSUAlbum objects
 */
@property (nonatomic, readonly) NSArray *albums;

/*!
 PSUPhoto objects
 */
@property (nonatomic, readonly) NSArray *photos;

- (void)requestAlbums;
- (void)requestPhotosForAlbumId:(NSString *)albumId;
- (void)cancel;

@end
