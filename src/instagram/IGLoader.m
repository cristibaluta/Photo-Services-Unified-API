//
//  IGLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "IGLoader.h"
#import "AppDelegate.h"

@implementation IGLoader

- (void) requestAlbums {
	
	NSArray *methods = [NSArray arrayWithObjects:@"/users/self/feed", @"/users/self/media/recent", @"/users/self/media/liked", @"/media/popular", nil];
	NSArray *titles = [NSArray arrayWithObjects:@"My feed", @"My photos", @"Photos that i liked", @"Popular", nil];
	
	for (int i=0; i<[methods count]; i++) {
		PSUAlbum *album = [[PSUAlbum alloc] init];
		album.type = 3;
		album.name = [titles objectAtIndex:i];
		album.count = 1;
		album.albumId = [methods objectAtIndex:i];
		album.coverImage = [UIImage imageNamed:@"CellHeaderInstagram"];
		[self.albums addObject:album];
	}
	
	[self.delegate albumsLoaded:self.albums];
}

- (void) requestPhotosForAlbumId:(NSString*)albumId {
	
	[self.photos removeAllObjects];
	RCLog(@"requestPhotosForAlbumId %@", albumId);
	AppDelegate *app = [[UIApplication sharedApplication] delegate];
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:albumId, @"method", @"-1", @"count", nil];
    [app.login.instagram requestWithParams:params delegate:self];
}



#pragma mark - IGRequestDelegate

- (void)request:(IGRequest *)request didFailWithError:(NSError *)error {
    RCLog(@"Instagram did fail: %@", error);
    
}

- (void)request:(IGRequest *)request didLoad:(id)result {
    //RCLog(@"Instagram did load: %@", result);
    NSArray *data = (NSArray*)[result objectForKey:@"data"];
	RCLog(@"did load %i", [data count]);
	for (id obj in data) {
		WebPhoto *photo = [[WebPhoto alloc] init];
		NSDictionary *images = [obj objectForKey:@"images"];
		//RCLog(@"%@", images);
		photo.type = 3;
		photo.thumbUrl = [NSURL URLWithString:[[images objectForKey:@"thumbnail"] objectForKey:@"url"]];
		photo.sourceUrl = [NSURL URLWithString:[[images objectForKey:@"standard_resolution"] objectForKey:@"url"]];
		photo.selected = YES;
		NSString *timestamp = [obj objectForKey:@"created_time"];
		photo.date = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
		[self.photos addObject:photo];
	}
	
    [self.delegate photosLoaded:self.photos];
}


@end
