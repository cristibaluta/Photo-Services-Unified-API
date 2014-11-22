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
#import "PSUWebPhoto.h"
#import "PSULoader.h"
//#import "ISPhotosManager.h"

@interface FBLoader : PSULoader {
	
	FBRequest *req;
}

@end
