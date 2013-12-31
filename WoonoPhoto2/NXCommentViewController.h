//
//  NXCommentViewController.h
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 11..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXCommentViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *cmtTitle;
@property (weak, nonatomic) IBOutlet UILabel *cmtComment;
@property (weak, nonatomic) IBOutlet UIImageView *cmtPhoto;
@property NSDictionary * selectedData;
@end
