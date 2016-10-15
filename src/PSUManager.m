//
//  PSUManager.m
//  TestAllServicesApp
//
//  Created by Baluta Cristian on 25/10/14.
//  Copyright (c) 2014 Baluta Cristian. All rights reserved.
//

#import "PSUManager.h"
#import "LIBLoader.h"
#import "FBLoader.h"
#import "IGLoader.h"
#import "NIFLoader.h"
#import "SILoader.h"
#import "PXLoader.h"

@implementation PSUManager {
	// Services
	LIBLoader *_libraryLoader;
	FBLoader *_facebookLoader;
	IGLoader *_instagramLoader;
	NIFLoader *_nifLoader;
	SILoader *_photosightLoader;
	PXLoader *_pxLoader;
}

+ (instancetype)sharedManager {
	static PSUManager *_sharedManager = nil;
	static dispatch_once_t oncePredicate;
	dispatch_once(&oncePredicate, ^{
		_sharedManager = [[self alloc] init];
	});
	return _sharedManager;
}

- (void)requestAlbums:(PSUSourceType)type completion:(void(^)(NSArray *albums))block {
	NSLog(@"PSUManager requestAlbum %i", type);
	switch (type) {
		case PSUSourceTypeAssetsLibrary:
			_libraryLoader = [[LIBLoader alloc] init];
			[_libraryLoader requestAlbums:block];
			break;
			
		case PSUSourceTypeFacebook:
			_facebookLoader = [[FBLoader alloc] init];
			[_facebookLoader requestAlbums:block];
			break;
			
		case PSUSourceTypeInstagram:
			_instagramLoader = [[IGLoader alloc] init];
			[_instagramLoader requestAlbums:block];
			break;
			
		case PSUSourceType500Px:
			_pxLoader = [[PXLoader alloc] init];
			[_pxLoader requestAlbums:block];
			break;
            
        case PSUSourceTypePhotosightRu:
            break;
            
        case PSUSourceTypeNifMagazine:
            break;
	}
}

- (void)requestPhotosForAlbum:(PSUAlbum *)album completion:(void(^)(NSArray *photos))block {
	NSLog(@"ISPhotosManager requestPhotos %i", album.type);
	switch (album.type) {
			
		case PSUSourceTypeAssetsLibrary:
			[_libraryLoader requestPhotosForAlbumId:album.albumId completion:block];
			break;
			
		case PSUSourceTypeFacebook:
			[_facebookLoader requestPhotosForAlbumId:album.albumId completion:block];
			break;
			
		case PSUSourceTypeInstagram:
			[_instagramLoader requestPhotosForAlbumId:album.albumId completion:block];
			break;
			
		case PSUSourceType500Px:
			[_pxLoader requestPhotosForAlbumId:album.albumId completion:block];
            break;
            
        case PSUSourceTypePhotosightRu:
            break;
            
        case PSUSourceTypeNifMagazine:
            break;
	}
}

- (NSUInteger)numberOfAlbums:(PSUSourceType)type {
	
	switch (type) {
			
		case PSUSourceTypeAssetsLibrary:
			return [_libraryLoader.albums count];
			break;
			
		case PSUSourceTypeFacebook:
			if (_facebookLoader == nil) return -1;
			return [_facebookLoader.albums count];
			break;
			
		case PSUSourceTypeInstagram:
			if (_instagramLoader == nil) return -1;
			return [_instagramLoader.albums count];
			break;
			
		case PSUSourceType500Px:
			if (_pxLoader == nil) return -1;
			return [_pxLoader.albums count];
            break;
            
        case PSUSourceTypePhotosightRu:
            break;
            
        case PSUSourceTypeNifMagazine:
            break;
	}
	return 0;
}

- (NSUInteger)numberOfPhotos:(PSUSourceType)type {
	
	switch (type) {
			
		case PSUSourceTypeAssetsLibrary:
			return [_libraryLoader.photos count];
			break;
			
		case PSUSourceTypeFacebook:
			return [_facebookLoader.photos count];
			break;
			
		case PSUSourceTypeInstagram:
			return [_instagramLoader.photos count];
            break;
            
        case PSUSourceType500Px:
            break;
            
        case PSUSourceTypePhotosightRu:
            break;
            
        case PSUSourceTypeNifMagazine:
            break;
	}
	return 0;
}

@end
