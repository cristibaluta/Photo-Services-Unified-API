//
//  PSUPhoto.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSUEnums.h"

@class PSUPhoto;

@protocol PSUPhotoDelegate <NSObject>

@required
- (void)photoFinishedLoading:(PSUPhoto *)photo;

@end

@interface PSUPhoto : NSObject

@property (nonatomic, weak) id<PSUPhotoDelegate> delegate;
@property (nonatomic, copy) NSIndexPath *indexPath;
@property (nonatomic, copy) NSIndexPath *sortedIndexPath;
@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL isLoading;
@property (nonatomic) PSUSourceType type;
@property (nonatomic, copy) NSURL *thumbUrl;
@property (nonatomic, copy) NSURL *sourceUrl;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic) CGRect faceRect;
@property (nonatomic) BOOL faceRectDone;
@property (nonatomic, copy) NSDate *date;

- (void)select:(BOOL)v;
- (void)preloadThumbImage;
- (void)preloadSourceImage;
- (void)dispatchLoadComplete;

@end
