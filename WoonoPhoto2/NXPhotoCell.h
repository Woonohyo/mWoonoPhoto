//
//  NXPhotoCell.h
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 11..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXPhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIImageView *cellPhoto;
@property (weak, nonatomic) IBOutlet UILabel *cellComment;


@end
