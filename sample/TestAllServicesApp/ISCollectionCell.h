//
//  PhotoButton.h
//  InstaSlide
//
//  Created by Baluta Cristian on 10/04/2013.
//  Copyright (c) 2013 Baluta Cristian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *markImage;
@property (nonatomic) int index;

- (void) select:(BOOL)sel;

@end
