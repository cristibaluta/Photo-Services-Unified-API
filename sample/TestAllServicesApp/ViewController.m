//
//  ViewController.m
//  TestAllServicesApp
//
//  Created by Baluta Cristian on 18/10/14.
//  Copyright (c) 2014 Baluta Cristian. All rights reserved.
//

#import "ViewController.h"
#import "PSUManager.h"
#import "PSULoginManager.h"
#import "ISTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
	PSUManager *_photosManager;
	PSULoginManager *_loginManager;
	NSArray *_albums;
	UITableView *_tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	
	_tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
	_tableView.separatorColor = [UIColor darkGrayColor];
	_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
	[self.view addSubview:_tableView];
	
	_photosManager = [PSUManager sharedManager];
	[_photosManager requestAlbums:PSUSourceTypeAssetsLibrary completion:^(NSArray *albums) {
		NSLog(@"%@", albums);
		_albums = albums;
		[_tableView reloadData];
	}];
}


#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSUInteger nr = [_photosManager numberOfAlbums:(int)section];
	if (nr == -1) {
		nr = 1;
	}
	return nr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Buid the cell
	static NSString *identif = @"AlbumCellIdentifier";
	
	ISTableViewCell *cell = (ISTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identif];
	
	if (cell == nil) {
		cell = [[ISTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
	}
	
	// Add info to the cell
	[cell showAlbumState];
	
	NSUInteger section = indexPath.section;
	NSUInteger row = indexPath.row;
	PSUAlbum *album = (PSUAlbum *)_albums[row];
	album.indexPath = indexPath;
	album.delegate = self;
	
	if (indexPath.section == PSUSourceTypeAssetsLibrary) {
		cell.customTextLabel.text = album.name;
		cell.customImageView.image = album.coverImage;
	}
	else if (indexPath.section == PSUSourceTypeFacebook) {
		if (![_loginManager isLoggedIn:PSUSourceTypeFacebook]) {
//			[cell showLoginState];
//			[cell.button setImage:nil title:@"LOGIN TO FACEBOOK"];
//			cell.customImageView.image = nil;
		}
//		else {
//			//cell.customTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", album.name, album.count];
//			cell.customTextLabel.text = album.name;
//			
//			if (album.coverImage == nil) {
//				cell.customImageView.image = nil;
//				
//				dispatch_async(dispatch_get_global_queue(0,0),^{
//					
//					[album preloadCoverImage];
//					
//				});
//			}
//			else {
//				cell.customImageView.image = album.coverImage;
//			}
//		}
	}
	else if (indexPath.section == PSUSourceTypeInstagram) {
		if (![_loginManager isLoggedIn:PSUSourceTypeInstagram]) {
//			[cell showLoginState];
//			[cell.button setImage:nil title:@"LOGIN TO INSTAGRAM"];
//			cell.customImageView.image = nil;
		}
//		else {
//			//cell.customTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", album.name, album.count];
//			cell.customTextLabel.text = album.name;
//			cell.customImageView.image = nil;
//			if (album.coverImage == nil) {
//				cell.customImageView.image = nil;
//				
//				dispatch_async(dispatch_get_global_queue(0,0),^{
//					
//					[album preloadCoverImage];
//					
//				});
//			}
//			else {
//				cell.customImageView.image = album.coverImage;
//			}
//		}
	}
	else if (indexPath.section == PSUSourceType500Px) {
		if (![_loginManager isLoggedIn:PSUSourceType500Px]) {
			[cell showLoginState];
//			[cell.button setImage:nil title:@"LOGIN TO 500PX"];
			cell.customImageView.image = nil;
		}
		else {
			//cell.customTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", album.name, album.count];
			cell.customTextLabel.text = album.name;
			cell.customImageView.image = nil;
			if (album.coverImage == nil) {
				cell.customImageView.image = nil;
				
				dispatch_async(dispatch_get_global_queue(0,0),^{
					
					//[album preloadCoverImage];
					
				});
			}
			else {
				cell.customImageView.image = album.coverImage;
			}
		}
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, -1, tableView.frame.size.width, 50)];
	v.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.9];
	
	NSString *symbol;
	NSString *title;
	
	switch (section) {
		case PSUSourceTypeAssetsLibrary: symbol = @"CellHeaderFolder"; title = @"Local Albums"; break;
		case PSUSourceTypeFacebook: symbol = @"CellHeaderFacebook"; title = @"Facebook Albums"; break;
		case PSUSourceTypeInstagram: symbol = @"CellHeaderInstagram"; title = @"Instagram Albums"; break;
		case PSUSourceType500Px: symbol = @"CellHeaderPx500"; title = @"500PX Albums"; break;
	}
	
	UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:symbol]];
	img.frame = CGRectMake(7, 8, 35, 35);
	img.alpha = 0.4;
	[v addSubview:img];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 18, 200, 13)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor darkGrayColor];
	label.font = [UIFont boldSystemFontOfSize:13];
	label.text = title;
	[v addSubview:label];
	
	return v;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
	PSUAlbum *album = (PSUAlbum *)_albums[row];
	
	//[tableView_ deselectRowAtIndexPath:indexPath animated:YES];
	
	if (section == PSUSourceTypeAssetsLibrary) {
//		[delegate albumPicked:album];
	}
	else if (section == PSUSourceTypeFacebook) {
		
		if ([_loginManager isLoggedIn:PSUSourceTypeFacebook]) {
//			[delegate albumPicked:album];
		}
		else {
//			activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//			CGRect rect = activityView.frame;
//			rect.origin.x = 20;
//			rect.origin.y = 30;
//			activityView.frame = rect;
//			[[tableView cellForRowAtIndexPath:indexPath] addSubview:activityView];
//			[activityView startAnimating];
			
			[_loginManager login:PSUSourceTypeFacebook];
		}
	}
	else if (section == PSUSourceTypeInstagram) {
		
		if ([_loginManager isLoggedIn:PSUSourceTypeInstagram]) {
//			[delegate albumPicked:album];
		}
		else {
//			activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//			CGRect rect = activityView.frame;
//			rect.origin.x = 20;
//			rect.origin.y = 30;
//			activityView.frame = rect;
//			[[tableView cellForRowAtIndexPath:indexPath] addSubview:activityView];
//			[activityView startAnimating];
			
			[_loginManager login:PSUSourceTypeInstagram];
		}
	}
	else if (section == PSUSourceType500Px) {
		
		if ([_loginManager isLoggedIn:PSUSourceType500Px]) {
//			[delegate albumPicked:album];
		}
		else {
//			activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//			CGRect rect = activityView.frame;
//			rect.origin.x = 20;
//			rect.origin.y = 30;
//			activityView.frame = rect;
//			[[tableView cellForRowAtIndexPath:indexPath] addSubview:activityView];
//			[activityView startAnimating];
			
			[_loginManager login:PSUSourceType500Px];
		}
	}
}

@end
