//
//  AlbumTableViewCell.h
//  Instaslider
//
//  Created by Baluta Cristian on 14/04/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	Album,
	Loggin,
	Busy
} AlbumCellState;

@interface ISTableViewCell : UITableViewCell {
	AlbumCellState state;
}

@property (nonatomic, strong) UIImageView *customImageView;
@property (nonatomic, strong) UILabel *customTextLabel;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, strong) UIImageView *markImage;

- (void)showAlbumState;
- (void)showLoginState;

@end
