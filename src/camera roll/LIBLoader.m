//
//  LIBLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "LIBLoader.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PSUAlbum.h"
#import "LIBAlbum.h"
#import "LIBPhoto.h"
#import "PSUEnums.h"

@interface LIBLoader () {
	
	ALAssetsLibrary *_assetslibrary;
}
@end

@implementation LIBLoader

- (id) init {
	self = [super init];
	if (self) {
		_assetslibrary = [[ALAssetsLibrary alloc] init];
	}
	return self;
}

- (void)requestAlbums {
	NSLog(@"LIBLoader request albums");
	ALAssetsLibraryAccessFailureBlock failHandler = ^(NSError *error) {
		NSLog(@"failed");
    };
	
	ALAssetsLibraryGroupsEnumerationResultsBlock groupsEnumerator = ^(ALAssetsGroup *group, BOOL *stop) {
		//RCLog(@"%@", group);
        if (group != nil) {
			LIBAlbum *album = [[LIBAlbum alloc] initWithAssetGroup:group];
			
			album.type = PSUSourceTypeAssetsLibrary;
			album.count = (int)[group numberOfAssets];
			album.coverUrl = [group valueForProperty:ALAssetsGroupPropertyURL];
			album.albumId = [group valueForProperty:ALAssetsGroupPropertyPersistentID];
			album.name = [group valueForProperty:ALAssetsGroupPropertyName];
			album.coverImage = [UIImage imageWithCGImage:[group posterImage]];
			[_albums addObject:album];
        }
		else {
			[self.delegate albumsLoaded:self.albums];
		}
    };
	
	[_assetslibrary enumerateGroupsWithTypes:ALAssetsGroupAll
								 usingBlock:groupsEnumerator
							   failureBlock:failHandler];
	
}

- (void)requestPhotosForAlbumId:(NSString *)albumId {
	NSLog(@"LIBLoader request photos for album id %@", albumId);
	[_photos removeAllObjects];
	
	// Search the album with the albumId
	ALAssetsGroup *groupRef;
	for (LIBAlbum *album in self.albums) {
		if ([albumId isEqualToString:album.albumId]) {
			groupRef = album.groupRef;
			break;
		}
	}
	
	ALAssetsGroupEnumerationResultsBlock groupEnumerator = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
		
        if (asset != NULL) {
			
			NSDictionary *dict = [asset valueForProperty:ALAssetPropertyURLs];
			NSURL *url = [dict objectForKey:@"public.jpeg"];
			if (url != nil) {
				//RCLog(@"%@", url);
				LIBPhoto *cell = [[LIBPhoto alloc] init];
				cell.type = PSUSourceTypeAssetsLibrary;
				cell.thumbUrl = url;
				cell.sourceUrl = url;
				cell.selected = YES;
				cell.date = [asset valueForProperty:ALAssetPropertyDate];
				[_photos addObject:cell];
			}
        }
		else {
			[self.delegate photosLoaded:self.photos];
		}
    };
	
	[groupRef enumerateAssetsUsingBlock:groupEnumerator];
}

- (void)cancel {
	// There's nothing to cancel when enumerating the groups
}



@end
