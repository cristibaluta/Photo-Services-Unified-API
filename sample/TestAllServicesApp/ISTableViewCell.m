//
//  AlbumTableViewCell.m
//  Instaslider
//
//  Created by Baluta Cristian on 14/04/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import "ISTableViewCell.h"

@implementation ISTableViewCell
@synthesize customImageView, customTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		
		//image view
        customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 10, 60, 60)];
		customImageView.contentMode  = UIViewContentModeScaleAspectFill;
		customImageView.clipsToBounds = YES;
        [self.contentView addSubview:customImageView];
		
        //labels
        self.customTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,30,self.frame.size.width-80,25)];
		self.customTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
		//self.customTextLabel.font.kerning = NSAttr
		self.customTextLabel.textColor = [UIColor blackColor];
		self.customTextLabel.backgroundColor = [UIColor clearColor];
		self.customTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.customTextLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.customTextLabel];
        
		UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		bg.backgroundColor = [UIColor darkGrayColor];
		self.selectedBackgroundView = bg;
		
		
		_markImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-40, 30, 16, 16)];
		_markImage.image = [UIImage imageNamed:@"Checkmark"];
		_markImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		[self.selectedBackgroundView addSubview:_markImage];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	self.customTextLabel.textColor = selected ? [UIColor colorWithRed:0.2 green:0.68 blue:1 alpha:1] : [UIColor blackColor];
}

- (void) showAlbumState {
	self.customImageView.hidden = NO;
	self.customTextLabel.hidden = NO;
	self.button.hidden = YES;
}
- (void) showLoginState {
	
	if (self.button == nil) {
		self.button = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-140/2, 20, 140, 35)];
//		[self.button setImage:nil title:@"LOGIN"];
		self.button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		[self addSubview:self.button];
		self.button.userInteractionEnabled = NO;
	}
	
	self.customImageView.hidden = YES;
	self.customTextLabel.hidden = YES;
	self.button.hidden = NO;
}


@end
