//
//  LIBPhoto.m
//  Instaslider
//
//  Created by Baluta Cristian on 06/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Photos/Photos.h>
#import "LIBPhoto.h"

@implementation LIBPhoto

- (instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        _asset = asset;
    }
    return self;
}

- (void)preloadThumbImage:(void(^)(PSUPhoto *))completionBlock {
	
    if (self.thumbImage == nil) {
		
        NSInteger retinaScale = [UIScreen mainScreen].scale;
        CGFloat thumbWidth = [UIScreen mainScreen].bounds.size.width / 4;
        CGSize retinaSquare = CGSizeMake(thumbWidth*retinaScale, thumbWidth*retinaScale);
        
        [[PHImageManager defaultManager] requestImageForAsset:_asset
                                                   targetSize:retinaSquare
                                                  contentMode:PHImageContentModeAspectFill
                                                      options:nil
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    
            self.thumbImage = result;
            dispatch_async(dispatch_get_main_queue(),^{
                completionBlock(self);
            });
        }];
	}
	else {
        completionBlock(self);
    }
}

- (void)preloadSourceImage {
	
	NSLog(@"preloadSourceImage %@", self.sortedIndexPath);
	if (self.sourceImage == nil) {
		
        CGSize imageSize = CGSizeMake(_asset.pixelWidth, _asset.pixelHeight);
        PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
        requestOptions.version = PHImageRequestOptionsVersionCurrent;
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        [[PHImageManager defaultManager] requestImageForAsset:_asset
                                                   targetSize:imageSize
                                                  contentMode:PHImageContentModeDefault
                                                      options:requestOptions
                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            self.sourceImage = result;
            dispatch_async(dispatch_get_main_queue(),^{
                [self dispatchLoadComplete];
            });
        }];
	}
	else {
        [self dispatchLoadComplete];
    }
}

@end
