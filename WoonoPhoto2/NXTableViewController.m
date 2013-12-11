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


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataModel = [[NXDataModel alloc] init];
    _dataModel.tableController = self;
	// Do any additional setup after loading the view.
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