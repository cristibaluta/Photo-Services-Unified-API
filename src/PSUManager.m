//
//  PSUManager.m
//  TestAllServicesApp
//
//  Created by Baluta Cristian on 25/10/14.
//  Copyright (c) 2014 Baluta Cristian. All rights reserved.
//

#import "PSUManager.h"
#import "FILELoader.h"
#import "LIBLoader.h"
#import "FBLoader.h"
#import "IGLoader.h"
#import "NIFLoader.h"
#import "SILoader.h"
#import "PXLoader.h"

@implementation PSUManager {
	// Services
    FILELoader *_fileLoader;
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

- (void)requestAlbums:(PSUSourceType)type completion:(void(^)(NSArray<PSUAlbum *> *albums))block {
	NSLog(@"PSUManager requestAlbum %lu", (unsigned long)type);
    switch (type) {
        case PSUSourceTypeAppDocuments:
            _fileLoader = [FILELoader new];
            [_fileLoader requestAlbums:block];
            break;
            
		case PSUSourceTypeAssetsLibrary:
			_libraryLoader = [LIBLoader new];
			[_libraryLoader requestAlbums:block];
			break;
			
		case PSUSourceTypeFacebook:
			_facebookLoader = [FBLoader new];
			[_facebookLoader requestAlbums:block];
			break;
			
		case PSUSourceTypeInstagram:
			_instagramLoader = [IGLoader new];
			[_instagramLoader requestAlbums:block];
			break;
			
		case PSUSourceType500Px:
			_pxLoader = [PXLoader new];
			[_pxLoader requestAlbums:block];
			break;
            
        case PSUSourceTypePhotosightRu:
            break;
            
        case PSUSourceTypeNifMagazine:
            break;
	}
}

- (void)requestPhotosForAlbum:(PSUAlbum *)album completion:(void(^)(NSArray<PSUPhoto *> *photos))block {
	NSLog(@"PSUPhotosManager requestPhotos %lu", (unsigned long)album.type);
	switch (album.type) {
            
        case PSUSourceTypeAppDocuments:
            [_fileLoader requestPhotosForAlbumId:album.albumId completion:block];
            break;
            
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
            
        case PSUSourceTypeAppDocuments:
            return [_fileLoader.albums count];
            break;
            
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

- (NSUInteger)numberOfPhotosForAlbum:(PSUAlbum *)album {
	
	switch (album.type) {
            
        case PSUSourceTypeAppDocuments:
            return [_fileLoader.photos count];
            break;
            
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
