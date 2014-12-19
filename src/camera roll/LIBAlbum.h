//
//  LIBAlbum.h
//  Instaslider
//
//  Created by Baluta Cristian on 05/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "PSUAlbum.h"

@interface LIBAlbum : PSUAlbum

- (instancetype)initWithAssetGroup:(ALAssetsGroup *)groupRef;

/*!
 
 */
@property (nonatomic, readonly) ALAssetsGroup *groupRef;

@end
