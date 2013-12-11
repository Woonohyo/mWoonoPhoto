//
//  NXViewController.m
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 11. 27..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import "NXViewController.h"
#import "NXDataModel.h"

@interface NXViewController ()

@end

@implementation NXViewController
{
    NXDataModel* _myModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _myModel = [[NXDataModel alloc] init];
    [self.navigationController setNavigationBarHidden: true];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonClick:(id)sender {
    NSLog(@"%@", _myModel);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: true];
}

@end
