//
//  ISLogin.h
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import <PXAPI/PXAPI.h>
#import "IGConnect.h"
#import "ISPhotosManager.h"

#define PX_CONSUMER_KEY @"oRhd5r3iEcGmvgxuSP4rOus3nQit9XoJmJm3o57G"
#define PX_CONSUMER_SECRET @"F5llLjIbcQnMahOT927qtG8CCcsOysKYtVVh7TwE"

@protocol ISLoginDelegate <NSObject>

@required
- (void) loginComplete:(ImageSourceType)type;
- (void) loginError:(ImageSourceType)type;

@end

@interface ISLoginManager : NSObject <IGSessionDelegate, UIAlertViewDelegate> {
	ImageSourceType loggingTo;
	NSUInteger px_user_id;
	BOOL fb_login;
}

@property (strong, nonatomic) id<ISLoginDelegate> delegate;
@property (strong, nonatomic) FBSession *session;
@property (strong, nonatomic) Instagram *instagram;
@property (strong, nonatomic) PXRequest *px500;

- (void) activate;
- (void) deactivate;
- (BOOL) handleOpenURL:(NSURL*)url;
- (void) login:(ImageSourceType)type;
- (BOOL) isLoggedIn:(ImageSourceType)type;

@end
