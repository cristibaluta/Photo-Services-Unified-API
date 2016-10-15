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
#import "PSUPhoto.h"

@interface PSUManager : NSObject

+ (instancetype)sharedManager;

- (void)requestAlbums:(PSUSourceType)type completion:(void(^)(NSArray<PSUAlbum *> *albums))block;
- (void)requestPhotosForAlbum:(PSUAlbum *)album completion:(void(^)(NSArray<PSUPhoto *> *photos))block;
- (NSUInteger)numberOfAlbums:(PSUSourceType)type;
- (NSUInteger)numberOfPhotosForAlbum:(PSUAlbum *)album;

@end
