//
//  LIBPhotosManager.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ISLoaderDelegate <NSObject>

- (void) albumsLoaded:(NSArray*)albums;
- (void) photosLoaded:(NSArray*)albums;

@end

@interface PSULoader : NSObject {
	
	
}

@property (nonatomic, weak) id<ISLoaderDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *albums;// ISAlbum objects
@property (nonatomic, strong) NSMutableArray *photos;// ISPhoto objects

- (void) requestAlbums;
- (void) requestPhotosForAlbumId:(NSString*)albumId;
- (void) cancel;

@end
