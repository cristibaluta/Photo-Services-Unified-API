//
//  ViewController.m
//  TestAllServicesApp
//
//  Created by Baluta Cristian on 18/10/14.
//  Copyright (c) 2014 Baluta Cristian. All rights reserved.
//

#import "ViewController.h"
#import "PSUManager.h"

@interface ViewController () {
	PSUManager *_photosManager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_photosManager = [PSUManager sharedManager];
	[_photosManager requestAlbums:PSUSourceTypeAssetsLibrary completion:^(NSArray *albums) {
		NSLog(@"%@", albums);
	}];
}

@end
