//
//  LIBPhoto.h
//  Instaslider
//
//  Created by Baluta Cristian on 06/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "PSUPhoto.h"

@interface LIBPhoto : PSUPhoto

- (instancetype)initWithAsset:(PHAsset *)asset;

@property (nonatomic, readonly) PHAsset *asset;

@end
