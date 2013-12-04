//
//  NXSecondViewController.m
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 11. 27..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import "NXSecondViewController.h"
#import "NXDataModel.h"

@interface NXSecondViewController ()


@end

@implementation NXSecondViewController {
    NXDataModel *_dataModel;
}

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
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    _dataModel = [[NXDataModel alloc] init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:tap];
	
}

-(void)didTap:(UITapGestureRecognizer*)rec {
    [self.userIdField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    // Dispose of any resources that can be recreated.
    [super didReceiveMemoryWarning];
}

- (IBAction)onLoginButton:(id)sender {
    [ _dataModel saveId:self.userIdField.text withPassword: self.passwordField.text ];
    NSLog(@"%@", _dataModel);
}

- (IBAction)onJoinButton:(id)sender {
    [ _dataModel saveId:self.userIdField.text withPassword: self.passwordField.text ];
    NSLog(@"%@", _dataModel);
}
- (IBAction)onFbButton:(id)sender {
    [ _dataModel saveId:self.userIdField.text withPassword: self.passwordField.text ];
    NSLog(@"%@", _dataModel);
}

@end
