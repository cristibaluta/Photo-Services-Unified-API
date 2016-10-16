//
//  LIBAlbum.m
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "LIBAlbum.h"
#import <Photos/Photos.h>

@interface LIBAlbum ()
@end

@implementation LIBAlbum

- (instancetype)initWithAssetCollection:(PHAssetCollection *)collection {
	self = [super init];
	if (self) {
		_collection = collection;
	}
	return self;
}

- (void)preloadCoverImage {
	
    NSInteger retinaScale = [UIScreen mainScreen].scale;
    CGFloat thumbWidth = [UIScreen mainScreen].bounds.size.width / 4;
    CGSize retinaSquare = CGSizeMake(thumbWidth*retinaScale, thumbWidth*retinaScale);
    
//    PHImageRequestOptions *cropToSquare = [[PHImageRequestOptions alloc] init];
//    cropToSquare.resizeMode = PHImageRequestOptionsResizeModeExact;
//    
//    CGFloat cropSideLength = MIN(asset.pixelWidth, asset.pixelHeight);
//    CGRect square = CGRectMake(0, 0, cropSideLength, cropSideLength);
//    CGRect cropRect = CGRectApplyAffineTransform(square,
//                                                 CGAffineTransformMakeScale(1.0 / asset.pixelWidth,
//                                                                            1.0 / asset.pixelHeight));
//    
//    cropToSquare.normalizedCropRect = cropRect;
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:_collection options:nil];
    PHAsset *asset = [assetsFetchResult objectAtIndex:0];
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:retinaSquare
                                              contentMode:PHImageContentModeAspectFit
                                                  options:nil
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
        self.coverImage = result;
        [self dispatchLoadComplete];
    }];
}

@end
