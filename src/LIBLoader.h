//
//  LIBLoader.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ISLoader.h"
#import "ISAlbum.h"
#import "LIBAlbum.h"
#import "LIBPhoto.h"
//#import "ISPhotosManager.h"

@interface LIBLoader : ISLoader {
	
	ALAssetsLibrary *assetslibrary;
}


@end
