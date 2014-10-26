//
//  ISPhoto.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSUPhoto;

@protocol ISPhotoDelegate <NSObject>
- (void)loadFinishedForPhoto:(PSUPhoto*)photo;
@end

@interface PSUPhoto : NSObject

@property (nonatomic, weak) id<ISPhotoDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSIndexPath *sortedIndexPath;
@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL isLoading;
@property (nonatomic) int type;// ISType
@property (nonatomic, strong) NSURL *thumbUrl;
@property (nonatomic, strong) NSURL *sourceUrl;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic) CGRect faceRect;
@property (nonatomic) BOOL faceRectDone;
@property (nonatomic, strong) NSDate *date;

- (void)select:(BOOL)v;
- (void)preloadThumbImage;
- (void)preloadSourceImage;
- (void)dispatchLoadComplete;

@end
