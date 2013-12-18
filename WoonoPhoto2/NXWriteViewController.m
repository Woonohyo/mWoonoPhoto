//
//  NXWriteViewController.m
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 18..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import "NXWriteViewController.h"

@interface NXWriteViewController ()

@end

@implementation NXWriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _writeImageView.image = _internalImage;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareData:(UIImage *)image
{
    _internalImage = image;
}

- (IBAction)uploader:(id)sender {
}

- (IBAction)onUploadClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
