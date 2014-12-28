//
//  PXLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 08/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "PXAPI.h"
#import "PXLoader.h"
#import "PSUAlbum.h"
#import "PSUWebPhoto.h"

@implementation PXLoader

- (void)requestAlbums:(void (^)(NSArray *))block {
	
	NSArray *ids = [NSArray arrayWithObjects:@"0", @"1", @"2", nil];
	NSArray *titles = [NSArray arrayWithObjects:@"My photos", @"Friends", @"Favourites", nil];
	
	for (int i=0; i<[ids count]; i++) {
		PSUAlbum *album = [[PSUAlbum alloc] init];
		album.type = 4;
		album.name = [titles objectAtIndex:i];
		album.count = 1;
		album.albumId = [ids objectAtIndex:i];
		album.coverImage = [UIImage imageNamed:@"CellHeaderPx500"];
		[_albums addObject:album];
	}
	
	block(_albums);
}

- (void)requestPhotosForAlbumId:(NSString *)albumId completion:(void (^)(NSArray *))block {
	
	[_photos removeAllObjects];
	NSUInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"px_user_id"];
	[PXRequest requestForPhotosOfUserID:uid  userFeature:[albumId integerValue] resultsPerPage:100 completion:^(NSDictionary *results, NSError *error) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//		RCLog(@"%@", results);
//		RCLog(@"%@", error);
		if (results) {
			NSArray *photos = [results valueForKey:@"photos"];
			
			for (NSDictionary *obj in photos) {
				
				PSUWebPhoto *photo = [[PSUWebPhoto alloc] init];
				photo.type = 4;
				
				NSArray *images = [obj valueForKey:@"image_url"];
				
				photo.thumbUrl = [NSURL URLWithString:[images[0] stringByReplacingOccurrencesOfString:@"/3." withString:@"/2."]];
				photo.sourceUrl = [NSURL URLWithString:[images[0] stringByReplacingOccurrencesOfString:@"/3." withString:@"/4."]];
				photo.selected = YES;
				//NSString *datestr = [obj objectForKey:@"created_at"];//"created_at" = "2012-07-08T14:59:13-04:00";
				[_photos addObject:photo];
			}
		}
		block(_photos);
	}];
}

/*"image_url" =             (
						   "http://pcdn.500px.net/9388003/e08ab2bf3ca4dc143df2ab2f64f9e9db9a90eb3f/3.jpg",
						   "http://pcdn.500px.net/9388003/e08ab2bf3ca4dc143df2ab2f64f9e9db9a90eb3f/4.jpg"
						   );
images =             (
					  {
						  size = 3;
						  url = "http://pcdn.500px.net/9388003/e08ab2bf3ca4dc143df2ab2f64f9e9db9a90eb3f/3.jpg";
					  },
					  {
						  size = 4;
						  url = "http://pcdn.500px.net/9388003/e08ab2bf3ca4dc143df2ab2f64f9e9db9a90eb3f/4.jpg";
					  }
					  );*/

- (void)cancel {
	// There's nothing to cancel when enumerating the groups
}

@end
