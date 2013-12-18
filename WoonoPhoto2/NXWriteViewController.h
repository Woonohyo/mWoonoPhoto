//
//  NXWriteViewController.h
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 18..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXWriteViewController : UIViewController
{
    UIImage * _internalImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *writeImageView;
@property (weak, nonatomic) IBOutlet UITextView *writeTextView;
- (void)prepareData:(UIImage*)image;
- (IBAction)onUploadClick:(id)sender;

@end
