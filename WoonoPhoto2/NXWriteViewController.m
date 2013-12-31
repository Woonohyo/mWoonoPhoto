//
//  NXWriteViewController.m
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 18..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import "NXWriteViewController.h"
#import "NXDataModel.h"

@interface NXWriteViewController () <UITextViewDelegate, UITextFieldDelegate>

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:tap];
	// Do any additional setup after loading the view.
    _writeTextView.delegate = self;
}

-(void)didTap:(UITapGestureRecognizer*)rec {
    [self.writeTextView resignFirstResponder];
    [self.writeTitleView resignFirstResponder];
    [self.writeImageView resignFirstResponder];
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

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (textView == self.writeTextView) {
        [UIView beginAnimations:@"TextViewUpAnimation" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        CGRect newframe = self.view.frame;
        newframe.origin.y = -150;
        self.view.frame = newframe;
        [UIView commitAnimations];
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
        if (textView == self.writeTextView) {
        [UIView beginAnimations:@"TextViewDownAnimation" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        CGRect newframe = self.view.frame;
        newframe.origin.y = 0;
        self.view.frame = newframe;
        [UIView commitAnimations];
    }
    return YES;
}


@end