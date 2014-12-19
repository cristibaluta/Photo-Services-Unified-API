//
//  LIBLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "SILoader.h"

@interface SILoader ()
@end

@implementation SILoader

- (id) init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (void)requestAlbums {
	NSLog(@"SILoader request albums");
//	ALAssetsLibraryAccessFailureBlock failHandler = ^(NSError *error) {
//		NSLog(@"failed");
//    };
//	
//	ALAssetsLibraryGroupsEnumerationResultsBlock groupsEnumerator = ^(ALAssetsGroup *group, BOOL *stop) {
//		//RCLog(@"%@", group);
//        if (group != nil) {
//			CRAlbum *album = [[CRAlbum alloc] init];
//			
//			album.groupRef = group;
//			album.type = 1;
//			album.count = [group numberOfAssets];
//			album.coverUrl = [group valueForProperty:ALAssetsGroupPropertyURL];
//			album.albumId = [group valueForProperty:ALAssetsGroupPropertyPersistentID];
//			album.name = [group valueForProperty:ALAssetsGroupPropertyName];
//			album.coverImage = [UIImage imageWithCGImage:[group posterImage]];
//			[self.albums addObject:album];
//        }
//		else {
//			[self.delegate albumsLoaded:self.albums];
//		}
//    };
	
}

- (void)requestPhotosForAlbumId:(NSString *)albumId {
//	NSLog(@"LIBLoader request photos for album id %@", albumId);
//	[self.photos removeAllObjects];
//	// Search the album with the albumId
//	ALAssetsGroup *groupRef;
//	for (CRAlbum *album in self.albums) {
//		if ([albumId isEqualToString:album.albumId]) {
//			groupRef = album.groupRef;
//			break;
//		}
//	}
//	
//	ALAssetsGroupEnumerationResultsBlock groupEnumerator = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
//		
//        if (asset != NULL) {
//			
//			NSDictionary *dict = [asset valueForProperty:ALAssetPropertyURLs];
//			NSURL *url = [dict objectForKey:@"public.jpeg"];
//			if (url != nil) {
//				//RCLog(@"%@", url);
//				CRPhoto *cell = [[CRPhoto alloc] init];
//				cell.type = 1;//ISTypeLibrary;
//				cell.thumbUrl = url;
//				cell.sourceUrl = url;
//				cell.selected = YES;
//				cell.date = [asset valueForProperty:ALAssetPropertyDate];
//				[self.photos addObject:cell];
//			}
//        }
//		else {
//			[self.delegate photosLoaded:self.photos];
//		}
//    };
//	
//	[groupRef enumerateAssetsUsingBlock:groupEnumerator];
}

- (void)cancel {
	// There's nothing to cancel when enumerating the groups
}



@end
