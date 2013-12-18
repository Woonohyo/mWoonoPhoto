//
//  NXSecondViewController.h
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 11. 27..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXSecondViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *userIdField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)onLoginButton:(id)sender;

- (IBAction)onJoinButton:(id)sender;


@end
