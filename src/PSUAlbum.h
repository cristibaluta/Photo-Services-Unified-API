//
//  ISAlbum.h
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ISAlbumDelegate <NSObject>
- (void) loadFinishedForIndexPath:(NSIndexPath*)indexPath;
@end

@interface PSUAlbum : NSObject

@property (nonatomic, weak) id<ISAlbumDelegate> delegate;
@property (nonatomic) int type;// ISType
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic) int count;
@property (nonatomic, retain) NSURL *coverUrl;
@property (nonatomic, retain) UIImage *coverImage;
@property (nonatomic, retain) NSString *albumId;
@property (nonatomic, retain) NSString *name;

@property (nonatomic) BOOL busy;

- (void)preloadCoverImage;
- (void)dispatchLoadComplete;

@end

