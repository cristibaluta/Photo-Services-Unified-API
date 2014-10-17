//
//  FBLoader.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FBAlbum.h"
#import "WebPhoto.h"
#import "ISLoader.h"
//#import "ISPhotosManager.h"

@interface FBLoader : ISLoader {
	
	FBRequest *req;
}

@end
