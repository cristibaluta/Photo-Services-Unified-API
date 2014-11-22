//
//  VLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 08/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "VLoader.h"

@implementation VLoader


- (void)requestAlbums {
	RCLog(@"VLoader request albums");
	
	NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectoryPath error:nil];
	
	for (NSString *file in dirContents) {
		RCLog(@"%@", file);
		
		if ([file hasSuffix:@".mp4"] && ![file hasSuffix:@"temp.mp4"]) {
			NSArray *comps = [file componentsSeparatedByString:@"/"];
			VItem *album = [[VItem alloc] init];
			
			album.type = 0;
			album.count = 1;
			album.coverImage = [UIImage imageNamed:@"SymbolCamera"];
			album.albumId = [documentsDirectoryPath stringByAppendingFormat:@"/%@", file];
			album.name = [comps lastObject];
			[self.albums addObject:album];
		}
	}
}

@end
