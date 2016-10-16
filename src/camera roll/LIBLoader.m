//
//  LIBLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "LIBLoader.h"
#import <Photos/Photos.h>
#import "PSUAlbum.h"
#import "LIBAlbum.h"
#import "LIBPhoto.h"
#import "PSUEnums.h"
#import "RCLog.h"

@interface LIBLoader () {
	PHPhotoLibrary *_library;
}
@end

@implementation LIBLoader

- (instancetype)init {
	self = [super init];
	if (self) {
		_library = [PHPhotoLibrary sharedPhotoLibrary];
	}
	return self;
}

- (void)requestAlbums:(void(^)(NSArray<PSUAlbum *> *albums))block {
	
    [_albums removeAllObjects];
    
    PHFetchOptions *userAlbumsOptions = [PHFetchOptions new];
    userAlbumsOptions.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0"];
    
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                                    subtype:PHAssetCollectionSubtypeAny
                                                                                                    options:userAlbumsOptions];
    [assetCollections enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LIBAlbum *album = [[LIBAlbum alloc] initWithAssetCollection:obj];
        
        album.type = PSUSourceTypeAssetsLibrary;
        album.count = obj.estimatedAssetCount;
        album.coverUrl = nil;
        album.albumId = obj.localIdentifier;
        album.name = obj.localizedTitle;
        [_albums addObject:album];
        RCLogO(album.name);
    }];
    block(_albums);
}

- (void)requestPhotosForAlbumId:(NSString *)albumId completion:(void(^)(NSArray<PSUPhoto *> *photos))block {
	NSLog(@"LIBLoader request photos for album id %@", albumId);
	[_photos removeAllObjects];
	
	// Search the album with the albumId
	PHAssetCollection *collection;
	for (LIBAlbum *album in self.albums) {
		if ([albumId isEqualToString:album.albumId]) {
			collection = album.collection;
			break;
		}
	}
	
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage];

    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:options];
    
    NSLog(@"sub album title is %@, count is %ld", collection.localizedTitle, assetsFetchResult.count);
    if (assetsFetchResult.count > 0) {
        for (PHAsset *asset in assetsFetchResult) {
//            RCLogO(asset);
            LIBPhoto *cell = [[LIBPhoto alloc] initWithAsset:asset];
            cell.type = PSUSourceTypeAssetsLibrary;
            cell.selected = YES;
            cell.date = asset.creationDate;
            [_photos addObject:cell];
        }
        block(_photos);
    }
}

- (void)cancel {
	// There's nothing to cancel when enumerating the groups
}

@end
