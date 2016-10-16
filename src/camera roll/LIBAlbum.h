//
//  LIBAlbum.h
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "PSUAlbum.h"

@interface LIBAlbum : PSUAlbum

- (instancetype)initWithAssetCollection:(PHAssetCollection *)collection;

@property (nonatomic, readonly) PHAssetCollection *collection;

@end
