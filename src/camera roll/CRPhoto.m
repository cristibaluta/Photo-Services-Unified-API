//
//  LIBPhoto.m
//  Instaslider
//
//  Created by Baluta Cristian on 06/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "CRPhoto.h"

@implementation CRPhoto

- (void)preloadThumbImage {
	
    if (self.thumbImage == nil) {
		
		ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset){
			
			self.thumbImage = [UIImage imageWithCGImage:[myasset thumbnail]];
			[self dispatchLoadComplete];
		};
		ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror){
			NSLog(@"Cant get image - %@", [myerror localizedDescription]);
		};
		
		ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
		[assetslibrary assetForURL:self.thumbUrl resultBlock:resultblock failureBlock:failureblock];
	}
	else {
        [self dispatchLoadComplete];
    }
}

- (void)preloadSourceImage {
	
	NSLog(@"preloadSourceImage %@", self.sortedIndexPath);
	if (self.sourceImage == nil) {
		
		ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset){
			//RCLog(@"resultblock %@", myasset);
			ALAssetRepresentation *rep = [myasset defaultRepresentation];
			//CGImageRef iref = [rep fullResolutionImage];
			CGImageRef iref = [rep fullScreenImage];
			if (iref) {
				self.sourceImage = [UIImage imageWithCGImage:iref];
				[self dispatchLoadComplete];
			}
			else {
				NSLog(@"error creating the fullscreen version of the image");
			}
		};
		ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror){
			NSLog(@"Cant get image - %@", [myerror localizedDescription]);
		};
		
		ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
		[assetslibrary assetForURL:self.sourceUrl resultBlock:resultblock failureBlock:failureblock];
	}
	else {
        [self dispatchLoadComplete];
    }
}


@end
