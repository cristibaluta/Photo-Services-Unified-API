//
//  VLoader.m
//  Instaslider
//
//  Created by Baluta Cristian on 08/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "FILELoader.h"
#import "FILEItem.h"

@implementation FILELoader


- (void)requestAlbums:(void(^)(NSArray<PSUAlbum *> *albums))block {
	RCLog(@"VLoader request albums");
    
    [_albums removeAllObjects];
    
	NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectoryPath error:nil];
	
	for (NSString *file in dirContents) {
		RCLog(@"%@", file);
		
		if ([file hasSuffix:@".mp4"] && ![file hasSuffix:@"temp.mp4"]) {
			NSArray *comps = [file componentsSeparatedByString:@"/"];
			FILEItem *album = [FILEItem new];
			album.type = 0;
			album.count = 1;
			album.coverImage = [UIImage imageNamed:@"SymbolCamera"];
			album.albumId = [documentsDirectoryPath stringByAppendingFormat:@"/%@", file];
			album.name = [comps lastObject];
			[_albums addObject:album];
		}
	}
    block(_albums);
}

@end
