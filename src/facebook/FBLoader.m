//
//  FBLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "FBLoader.h"

@implementation FBLoader

- (void) requestAlbums {
	
	id completionHandler = ^(FBRequestConnection *connection, id result, NSError *error) {
		
		if (result != nil) {
			RCLog(@"%@", result);
			NSArray *a = [result objectForKey:@"data"];
			
			for (id obj in a) {
				if ([obj objectForKey:@"count"] == nil || [[obj objectForKey:@"count"] integerValue] < 2) {
					continue;
				}
				FBAlbum *album = [[FBAlbum alloc] init];
				album.type = 2;
				album.name = [obj objectForKey:@"name"];
				album.count = [[obj objectForKey:@"count"] integerValue];
				album.albumId = [obj objectForKey:@"id"];
				album.coverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=album&access_token=%@", [obj objectForKey:@"cover_photo"], [[FBSession activeSession] accessToken]]];
				[self.albums addObject:album];
			}
			
			[self.delegate albumsLoaded:self.albums];
		}
		else {
			[self.delegate albumsLoaded:@[]];
		}
	};
	
	req = [FBRequest requestForGraphPath:@"me/albums"];
	[req startWithCompletionHandler:completionHandler];
	
}

- (void) requestPhotosForAlbumId:(NSString*)albumId {
	
	[self.photos removeAllObjects];
	//RCLog(@"requestPhotosForAlbumId %@", albumId);
	id completionHandler = ^(FBRequestConnection *connection, id result, NSError *error) {
		
		if (result != nil) {
			NSArray *data = [result objectForKey:@"data"];
			
			for (id obj in data) {
				WebPhoto *photo = [[WebPhoto alloc] init];
				photo.type = 2;
				photo.thumbUrl = [NSURL URLWithString:[obj objectForKey:@"picture"]];
				photo.sourceUrl = [NSURL URLWithString:[obj objectForKey:@"source"]];
				photo.selected = YES;
				//NSString *datestr = [obj objectForKey:@"created_time"];
				[self.photos addObject:photo];
			}
			[self.delegate photosLoaded:self.photos];
		}
	};
	
	NSString *graphPath = [NSString stringWithFormat:@"%@/photos?limit=500", albumId];
	req = [FBRequest requestForGraphPath:graphPath];
	[req startWithCompletionHandler:completionHandler];
}

- (void) cancel {
	// There's nothing to cancel when enumerating the groups
	
}


@end
