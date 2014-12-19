//
//  ISAlbum.h
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSUEnums.h"

@protocol PSUAlbumDelegate <NSObject>
- (void)loadFinishedForIndexPath:(NSIndexPath*)indexPath;
@end

@interface PSUAlbum : NSObject

@property (nonatomic, weak) id<PSUAlbumDelegate> delegate;

/*!
 The cover image for this album. It is available after is loaded
 */
@property (nonatomic) PSUSourceType type;// ISType

/*!
 IndexPath in the UITableView
 */
@property (nonatomic, copy) NSIndexPath *indexPath;

/*!
 The number of albums
 */
@property (nonatomic) int count;

/*!
 The URL of the image representative for this album
 */
@property (nonatomic, retain) NSURL *coverUrl;

/*!
 The image representative for this album. It is available after is loaded
 */
@property (nonatomic, retain) UIImage *coverImage;

/*!
 Album id
 */
@property (nonatomic, retain) NSString *albumId;

/*!
 Album name
 */
@property (nonatomic, retain) NSString *name;

@property (nonatomic) BOOL busy;

- (void)preloadCoverImage;
- (void)dispatchLoadComplete;

@end

