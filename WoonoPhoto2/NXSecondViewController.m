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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    _dataModel = [[NXDataModel alloc] init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:tap];
    [self.navigationController setNavigationBarHidden: false];
    
    _userIdField.delegate = self;
    _passwordField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _userIdField) {
        [_userIdField resignFirstResponder];
        [_passwordField becomeFirstResponder];
    }
    else if (textField == _passwordField) {
        [_passwordField resignFirstResponder];
        [self onLoginButton:self];
    }
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _userIdField) {
        [UIView beginAnimations:@"IdFieldUpAnimation" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        CGRect newframe = self.view.frame;
        newframe.origin.y = -40;
        self.view.frame = newframe;
        [UIView commitAnimations];
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == _userIdField) {
        [UIView beginAnimations:@"IdFieldDownAnimation" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        CGRect newframe = self.view.frame;
        newframe.origin.y = 0;
        self.view.frame = newframe;
        [UIView commitAnimations];
    }
    return YES;
}

-(void)didTap:(UITapGestureRecognizer*)rec {
    [self.userIdField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    // Dispose of any resources that can be recreated.
    [super didReceiveMemoryWarning];
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return [_dataModel loginCheckViaNetwork:self.passwordField.text userId:self.userIdField.text];
    //return [_dataModel authenticateId:self.userIdField.text withPassword:self.passwordField.text];
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