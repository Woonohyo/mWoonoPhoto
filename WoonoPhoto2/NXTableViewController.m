//
//  NXTableViewController.m
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 4..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import "NXTableViewController.h"
#import "NXDataModel.h"
#import "NXPhotoCell.h"
#import "UIImageView+WebCache.h"
#import "NXWriteViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface NXTableViewController ()

@end

@implementation NXTableViewController {
    NXDataModel* _dataModel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge id)kUTTypeImage])
    {
        UIImage* aImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:aImage];
        editor.delegate = self;
        [picker pushViewController:editor animated:YES];
        
        UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"사진" message:@"1장의 사진이 선택되었습니다." delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alertView1.alertViewStyle = UIAlertViewStyleDefault;
        [alertView1 show];
    }
}

-(void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    NXWriteViewController * writer = [self.storyboard instantiateViewControllerWithIdentifier:@"writeViewController"];
    [writer prepareData:image];
    [editor dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController pushViewController:writer animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataModel = [[NXDataModel alloc] init];
    _dataModel.tableController = self;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(newImage:)];
    self.navigationItem.rightBarButtonItem = rightButton;
	// Do any additional setup after loading the view.
}

-(void)newImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self.navigationController presentViewController:picker animated:YES completion:^{}];
}
                                                                                                                              
                                                                                                                              

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataModel getListSize];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* item = [_dataModel objectAtIndex:indexPath.row];
    
    NXPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    
    cell.cellTitle.text = [item objectForKey:@"title"];
    
    //URL을 통한 그림 삽입
    [cell.cellPhoto setImageWithURL: [NSURL URLWithString: [item objectForKey:@"image"]]];
    
    // 로컬에 있는 그림 파일 삽입
    // cell.cellPhoto.image = [UIImage imageNamed: [item objectForKey:@"image"]];
    
    cell.cellComment.text = [item objectForKey:@"content"];
    
    /*
     UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [item objectForKey:@"content"];
    cell.imageView.image = [UIImage imageNamed: [item objectForKey: @"image"]];
     */
    
    return cell;
}

// Manual Segue
// http://stackoverflow.com/questions/12250848/performing-segue-with-prototype-cells
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"BoardToCommentSegue" sender:indexPath];
}

@end