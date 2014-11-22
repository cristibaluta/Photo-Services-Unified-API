//
//  WebPhoto.m
//  Instaslider
//
//  Created by Baluta Cristian on 07/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "PSUWebPhoto.h"

@implementation PSUWebPhoto

- (void)preloadThumbImage {
	
    if (self.thumbImage == nil) {
		loadingThumb = YES;
		[self loadImageData:self.thumbUrl];
	}
	else {
        [self dispatchLoadComplete];
    }
}

- (void)preloadSourceImage {
	
	if (self.sourceImage == nil) {
		loadingThumb = NO;
		[self loadImageData:self.sourceUrl];
	}
	else {
        [self dispatchLoadComplete];
    }
}

- (void)loadImageData:(NSURL *)url {
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringCacheData
													   timeoutInterval:60.0];
	
	//	NSMutableString *postStr = [[NSMutableString alloc] init];
	//	for (id key in info) [postStr appendFormat:@"%@=%@&", key, [info objectForKey:key]];
	//	NSData *postData = [postStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	//
	//	[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	//	[request setHTTPMethod:@"POST"];
	//	[request setHTTPBody:postData];
	
	NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
															completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
																[self cacheImage:[NSData dataWithContentsOfURL:location]];
															}];
	
	[downloadTask resume];
}

- (void)cacheImage:(NSData*)imageData {
	if (loadingThumb) {
		self.thumbImage = [[UIImage alloc] initWithData:imageData];
	}
	else {
		self.sourceImage = [[UIImage alloc] initWithData:imageData];
	}
    
    [self dispatchLoadComplete];
}

@end
