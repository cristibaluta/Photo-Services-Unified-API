//
//  FBLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "FBLoader.h"
#import "FBAlbum.h"
#import "PSUWebPhoto.h"

@interface FBLoader () {
	
	FBRequest *_request;
}
@end

@implementation FBLoader

- (void)requestAlbums:(void (^)(NSArray *))block {
	
	id completionHandler = ^(FBRequestConnection *connection, id result, NSError *error) {
		
		if (result != nil) {
			NSLog(@"%@", result);
			NSArray *a = [result objectForKey:@"data"];
			
			for (id obj in a) {
				if ([obj objectForKey:@"count"] == nil || [[obj objectForKey:@"count"] integerValue] < 2) {
					continue;
				}
				FBAlbum *album = [[FBAlbum alloc] init];
				album.type = 2;
				album.name = [obj objectForKey:@"name"];
				album.count = (int)[[obj objectForKey:@"count"] integerValue];
				album.albumId = [obj objectForKey:@"id"];
				album.coverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=album&access_token=%@",
													   [obj objectForKey:@"cover_photo"],
													   [[FBSession activeSession] accessToken]]];
				[_albums addObject:album];
			}
			
			block(_albums);
		}
		else {
			block(@[]);
		}
	};
	
	_request = [FBRequest requestForGraphPath:@"me/albums"];
	[_request startWithCompletionHandler:completionHandler];
}

- (void)requestPhotosForAlbumId:(NSString *)albumId completion:(void (^)(NSArray *))block {
	
	[_photos removeAllObjects];
	//RCLog(@"requestPhotosForAlbumId %@", albumId);
	id completionHandler = ^(FBRequestConnection *connection, id result, NSError *error) {
		
		if (result != nil) {
			NSArray *data = [result objectForKey:@"data"];
			
			for (id obj in data) {
				PSUWebPhoto *photo = [[PSUWebPhoto alloc] init];
				photo.type = 2;
				photo.thumbUrl = [NSURL URLWithString:[obj objectForKey:@"picture"]];
				photo.sourceUrl = [NSURL URLWithString:[obj objectForKey:@"source"]];
				photo.selected = YES;
				//NSString *datestr = [obj objectForKey:@"created_time"];
				[_photos addObject:photo];
			}
			block(_photos);
		}
	};
	
	NSString *graphPath = [NSString stringWithFormat:@"%@/photos?limit=500", albumId];
	_request = [FBRequest requestForGraphPath:graphPath];
	[_request startWithCompletionHandler:completionHandler];
}

- (void)cancel {
	// There's nothing to cancel when enumerating the groups
	
}

@end
