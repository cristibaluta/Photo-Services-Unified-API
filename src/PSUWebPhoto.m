//
//  WebPhoto.m
//  Instaslider
//
//  Created by Baluta Cristian on 07/05/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "PSUWebPhoto.h"

@interface PSUWebPhoto() {
    BOOL loadingThumb;
}

@end

@implementation PSUWebPhoto

- (void)preloadThumbImage:(void(^)(PSUPhoto *))completionBlock {
	
    if (self.thumbImage == nil) {
		loadingThumb = YES;
		[self loadImageData:self.thumbUrl completion:completionBlock];
	}
	else {
        [self dispatchLoadComplete];
    }
}

- (void)preloadSourceImage {
	
	if (self.sourceImage == nil) {
		loadingThumb = NO;
		[self loadImageData:self.sourceUrl completion:nil];
	}
	else {
        [self dispatchLoadComplete];
    }
}

- (void)loadImageData:(NSURL *)url completion:(void(^)(PSUPhoto *))completionBlock {
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringCacheData
													   timeoutInterval:60.0];
	NSURLSessionDownloadTask *downloadTask =
    [session downloadTaskWithRequest:request
                   completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                       
                       [self cacheImage:[NSData dataWithContentsOfURL:location]];
                       
                       dispatch_async(dispatch_get_main_queue(),^{
                           if (completionBlock != nil) {
                               completionBlock(self);
                           }
                           [self dispatchLoadComplete];
                       });
    }];
	[downloadTask resume];
}

- (void)cacheImage:(NSData *)imageData {
    
	if (loadingThumb) {
		self.thumbImage = [[UIImage alloc] initWithData:imageData];
	} else {
		self.sourceImage = [[UIImage alloc] initWithData:imageData];
	}
}

@end
