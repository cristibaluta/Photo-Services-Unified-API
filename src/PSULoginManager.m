//
//  ISLogin.m
//  Instaslider
//
//  Created by Baluta Cristian on 04/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "PSULoginManager.h"
#import "PXAPI.h"
#import "IGConnect.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <UIKit/UIKit.h>

@interface PSULoginManager () <IGSessionDelegate, FBSDKLoginButtonDelegate, UIAlertViewDelegate> {
	
	PSUSourceType _loggingTo;
	NSUInteger _pxUserId;
	BOOL _fbLoggedIn;
    
    FBSDKLoginButton *_loginButton;
	Instagram *_igSession;
	PXRequest *_pxRequest;
}
@end

@implementation PSULoginManager

+ (instancetype)sharedManager {
    static PSULoginManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (id)init {
	self = [super init];
	if (self) {
		// Set some defaults
		[PXRequest setConsumerKey:PX_CONSUMER_KEY consumerSecret:PX_CONSUMER_SECRET];
        _loginButton = [[FBSDKLoginButton alloc] init];
        _loginButton.delegate = self;
	}
	return self;
}

- (void)activate {
	[FBSDKAppEvents activateApp];
}

- (void)deactivate {
//	[_fbSession close];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
	
	if ([[url absoluteString] hasPrefix:@"fb"]) {
        return [[FBSDKApplicationDelegate sharedInstance] application:app
                                                              openURL:url
                                                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                           annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                        ];
	}
	if ([[url absoluteString] hasPrefix:@"ig"]) {
		return [_igSession handleOpenURL:url];
	}
	return NO;
}

- (void)login:(PSUSourceType)type {
	
	switch (type) {
		
		case PSUSourceTypeFacebook: {
			RCLog(@"login to fb");
			NSArray *permissions = [[NSArray alloc] initWithObjects:@"user_photos", nil];
			
            _loginButton.readPermissions = permissions;
            [_loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            
//			id completeHandler = ^(FBSession *session, FBSessionState status, NSError *error) {
//				
//				RCLog(@"login %i %@", status, error);
//				RCLog(@"FBSessionStateCreated %i", FBSessionStateCreated);
//				RCLog(@"FBSessionStateCreatedTokenLoaded %i", FBSessionStateCreatedTokenLoaded);
//				RCLog(@"FBSessionStateOpen %i", FBSessionStateOpen);
//				RCLog(@"FBSessionStateOpenTokenExtended %i", FBSessionStateOpenTokenExtended);
//				RCLog(@"FBSessionStateClosedLoginFailed %i", FBSessionStateClosedLoginFailed);
//				RCLog(@"FBSessionStateClosed %i", FBSessionStateClosed);
//				
//				if (!error /*&& status == FBSessionStateOpen*/) {
//					RCLog(@"login fb ok");
//					_fbLoggedIn = YES;
//					[self.delegate loginComplete:PSUSourceTypeFacebook];
//				}
//				else {
//					RCLog(@"login error %@", error);
//					_loggingTo = -1;
//					_fbLoggedIn = NO;
//					[self.delegate loginError:PSUSourceTypeFacebook];
//				}
//			};
//			
//			BOOL lite = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"lite"] boolValue];
//			
//			FBSession *session = [[FBSession alloc] initWithAppID:nil
//													  permissions:nil
//												  urlSchemeSuffix:lite ? @"free" : nil
//											   tokenCacheStrategy:nil];
//			
//			[FBSession setActiveSession:session];
//			[session openWithBehavior:FBSessionLoginBehaviorUseSystemAccountIfPresent
//					completionHandler:completeHandler];
//			 
//			[FBSession openActiveSessionWithReadPermissions:permissions
//											   allowLoginUI:YES
//										  completionHandler:completeHandler];
		};
		break;
			
		case PSUSourceTypeInstagram: {
			NSLog(@"login to instagram");
			_igSession = [[Instagram alloc] initWithClientId:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"InstagramAppID"] delegate:nil];
			_igSession.sessionDelegate = self;
			[_igSession authorize:@[@"likes"]];
		}
		break;
			
		case PSUSourceType500Px: {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"500px Login"
															message:@"Enter in your 500px login credentials"
														   delegate:self
												  cancelButtonTitle:@"Cancel"
												  otherButtonTitles:@"Done", nil];
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
			
		default:
			break;
	}
}

- (BOOL)isLoggedIn:(PSUSourceType)type {
	
	switch (type) {
		
		case PSUSourceTypeFacebook:
            return [FBSDKAccessToken currentAccessToken];// && _fbLoggedIn;
			break;
		case PSUSourceTypeInstagram:
			return _igSession != nil;
			break;
		case PSUSourceType500Px:
			return _pxUserId > 0;
			break;
		default:
			break;
	}
	return NO;
}


#pragma mark - FBSDKLoginButtonDelegate

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error {
    
    NSLog(@"%@ %@", result, error);
    if (!error) {
        _fbLoggedIn = YES;
        [self.delegate loginComplete:PSUSourceTypeFacebook];
    }
    else {
        _loggingTo = -1;
        _fbLoggedIn = NO;
        [self.delegate loginError:PSUSourceTypeFacebook];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    _fbLoggedIn = NO;
}

#pragma - IGSessionDelegate

- (void)igDidLogin {
    // here i can store accessToken
    [[NSUserDefaults standardUserDefaults] setObject:_igSession.accessToken
                                              forKey:@"PSUSourceTypeInstagramAccessToken"];
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
	
    NSString *username = [[alertView textFieldAtIndex:0] text];
    NSString *password = [[alertView textFieldAtIndex:1] text];
    
	if (username == nil || password == nil) {
		[self.delegate loginError:PSUSourceType500Px];
		return;
	}
	
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	[PXRequest authenticateWithUserName:username password:password completion:^(BOOL success) {
		
		if (success) {
			[PXRequest requestForCurrentlyLoggedInUserWithCompletion:^(NSDictionary *results, NSError *error) {
				
				_pxUserId = [[[results objectForKey:@"user"] objectForKey:@"id"] integerValue];
				
				[[NSUserDefaults standardUserDefaults] setInteger:_pxUserId forKey:@"px_user_id"];
				[[NSUserDefaults standardUserDefaults] setObject:username forKey:@"500pxuser"];
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
