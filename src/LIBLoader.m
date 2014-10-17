//
//  LIBLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "LIBLoader.h"

@implementation LIBLoader

- (id) init {
	self = [super init];
	if (self) {
		assetslibrary = [[ALAssetsLibrary alloc] init];
	}
	return self;
}

- (void) requestAlbums {
	RCLog(@"LIBLoader request albums");
	ALAssetsLibraryAccessFailureBlock failHandler = ^(NSError *error) {
		RCLog(@"failed");
    };
	
	ALAssetsLibraryGroupsEnumerationResultsBlock groupsEnumerator = ^(ALAssetsGroup *group, BOOL *stop) {
		//RCLog(@"%@", group);
        if (group != nil) {
			LIBAlbum *album = [[LIBAlbum alloc] init];
			
			album.groupRef = group;
			album.type = 1;
			album.count = [group numberOfAssets];
			album.coverUrl = [group valueForProperty:ALAssetsGroupPropertyURL];
			album.albumId = [group valueForProperty:ALAssetsGroupPropertyPersistentID];
			album.name = [group valueForProperty:ALAssetsGroupPropertyName];
			album.coverImage = [UIImage imageWithCGImage:[group posterImage]];
			[self.albums addObject:album];
        }
		else {
			[self.delegate albumsLoaded:self.albums];
		}
    };
	
	[assetslibrary enumerateGroupsWithTypes:ALAssetsGroupAll
								 usingBlock:groupsEnumerator
							   failureBlock:failHandler];
	
}

- (void) requestPhotosForAlbumId:(NSString*)albumId {
	RCLog(@"LIBLoader request photos for album id %@", albumId);
	[self.photos removeAllObjects];
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
				cell.type = 1;//ISTypeLibrary;
				cell.thumbUrl = url;
				cell.sourceUrl = url;
				cell.selected = YES;
				cell.date = [asset valueForProperty:ALAssetPropertyDate];
				[self.photos addObject:cell];
			}
        }
		else {
			[self.delegate photosLoaded:self.photos];
		}
    };
	
	[groupRef enumerateAssetsUsingBlock:groupEnumerator];
}

- (void) cancel {
	// There's nothing to cancel when enumerating the groups
}



@end
