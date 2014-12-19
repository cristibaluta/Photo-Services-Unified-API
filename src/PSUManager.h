//
//  PSUManager.h
//  TestAllServicesApp
//
//  Created by Baluta Cristian on 25/10/14.
//  Copyright (c) 2014 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSUEnums.h"
#import "PSUAlbum.h"

@interface PSUManager : NSObject

+ (instancetype)sharedManager;

- (void)requestAlbums:(PSUSourceType)type completion:(void(^)(NSArray *albums))block;
- (void)requestPhotosForAlbum:(PSUAlbum *)album completion:(void(^)(NSArray *photos))block;
- (int)numberOfAlbums:(PSUSourceType)type;
- (int)numberOfPhotosForAlbum:(PSUAlbum *)album;

@end
