//
//  ISLogin.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "PSULoginManager.h"
#import "PSUEnums.h"

@interface PSULoginManager () <IGSessionDelegate, UIAlertViewDelegate> {
	PSUSourceType loggingTo;
	NSUInteger px_user_id;
	BOOL fb_login;
}
@end

@implementation PSULoginManager

- (id) init {
	self = [super init];
	if (self) {
		// Set some defaults
		loggingTo = nil;
		[PXRequest setConsumerKey:PX_CONSUMER_KEY consumerSecret:PX_CONSUMER_SECRET];
	}
	return self;
}

- (void)activate {
	[FBSession.activeSession handleDidBecomeActive];
}

- (void)deactivate {
	[self.session close];
}

- (BOOL) handleOpenURL:(NSURL*)url {
	NSLog(@"handleopenurl %@", url);
	if ([[url absoluteString] hasPrefix:@"fb"]) {
		return [[FBSession activeSession] handleOpenURL:url];
	}
	if ([[url absoluteString] hasPrefix:@"ig"]) {
		return [self.instagram handleOpenURL:url];
	}
	return NO;
}

- (void)login:(ImageSourceType)type {
	
	switch (type) {
		
		case PSUSourceTypeFacebook: {
			RCLog(@"login to fb");
			//NSArray *permissions = [[NSArray alloc] initWithObjects:@"user_photos", nil];
			
			id completeHandler = ^(FBSession *session, FBSessionState status, NSError *error) {
				
//				RCLog(@"login %i %@", status, error);
//				RCLog(@"FBSessionStateCreated %i", FBSessionStateCreated);
//				RCLog(@"FBSessionStateCreatedTokenLoaded %i", FBSessionStateCreatedTokenLoaded);
//				RCLog(@"FBSessionStateOpen %i", FBSessionStateOpen);
//				RCLog(@"FBSessionStateOpenTokenExtended %i", FBSessionStateOpenTokenExtended);
//				RCLog(@"FBSessionStateClosedLoginFailed %i", FBSessionStateClosedLoginFailed);
//				RCLog(@"FBSessionStateClosed %i", FBSessionStateClosed);
				
				if (!error /*&& status == FBSessionStateOpen*/) {
					RCLog(@"login fb ok");
					fb_login = YES;
					[self.delegate loginComplete:ISTypeFacebook];
				}
				else {
					RCLog(@"login error %@", error);
					loggingTo = nil;
					fb_login = NO;
					[self.delegate loginError:ISTypeFacebook];
				}
			};
			
			BOOL lite = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"lite"] boolValue];
			
			FBSession *session = [[FBSession alloc] initWithAppID:nil
													  permissions:nil
												  urlSchemeSuffix:lite ? @"free" : nil
											   tokenCacheStrategy:nil];
			
			[FBSession setActiveSession:session];
			[session openWithBehavior:FBSessionLoginBehaviorUseSystemAccountIfPresent
					completionHandler:completeHandler];
			 
//			[FBSession openActiveSessionWithReadPermissions:permissions
//											   allowLoginUI:YES
//										  completionHandler:completeHandler];
		};
		break;
			
		case PSUSourceTypeInstagram: {
			NSLog(@"login to instagram");
			self.instagram = [[Instagram alloc] initWithClientId:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"InstagramAppID"] delegate:nil];
			self.instagram.sessionDelegate = self;
			[self.instagram authorize:@[@"likes"]];
		}
		break;
			
		case PSUSourceType500Px: {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"500px Login" message:@"Enter in your 500px login credentials" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
			alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
			alert.delegate = self;
			
			NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"500pxuser"];
			if (userName != nil) {
				UITextField *textField = [alert textFieldAtIndex:0];
				textField.text = userName;
			}
			
			[alert show];
		}
		break;
			
		case PSUSourceTypePhotosightRu: {
			
		}
			break;
	}
}

- (BOOL)isLoggedIn:(PSUSourceType)type {
	
	switch (type) {
		
		case ISTypeFacebook:
			return [[FBSession activeSession] isOpen] && fb_login;
			break;
		case ISTypeInstagram:
			return self.instagram != nil;
			break;
		case ISTypePx500:
			return px_user_id > 0;
			break;
	}
	return NO;
}


#pragma - IGSessionDelegate

- (void)igDidLogin {
    // here i can store accessToken
    [[NSUserDefaults standardUserDefaults] setObject:self.instagram.accessToken forKey:@"PSUSourceTypeInstagramAccessToken"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[self.delegate loginComplete:PSUSourceTypeInstagram];
}

- (void)igDidNotLogin:(BOOL)cancelled {
	
    NSString *message = nil;
    if (cancelled) {
        message = @"Access cancelled!";
    } else {
        message = @"Access denied!";
    }
	[self.delegate loginError:PSUSourceTypeInstagram];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)igDidLogout {
}

- (void)igSessionInvalidated {
}

#pragma mark 500px login
#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    NSString *userName = [alertView[0] text];
    NSString *password = [alertView[1] text];
    
	if (userName == nil || password == nil) {
		[self.delegate loginError:ISTypePx500];
		return;
	}
	
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	[PXRequest authenticateWithUserName:userName password:password completion:^(BOOL success) {
		
		if (success) {
			[PXRequest requestForCurrentlyLoggedInUserWithCompletion:^(NSDictionary *results, NSError *error) {
				
				px_user_id = [[[results objectForKey:@"user"] objectForKey:@"id"] integerValue];
				
				[[NSUserDefaults standardUserDefaults] setInteger:px_user_id forKey:@"px_user_id"];
				[[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"500pxuser"];
				[self.delegate loginComplete:PSUSourceType500Px];
			}];
		}
		else {
			[self.delegate loginError:PSUSourceType500Px];
		}
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}];
}


@end
