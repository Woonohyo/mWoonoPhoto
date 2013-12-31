//
//  NXCommentViewController.m
//  WoonoPhoto2
//
//  Created by Wonhyo Yi on 2013. 12. 11..
//  Copyright (c) 2013년 NHN NEXT. All rights reserved.
//

#import "NXCommentViewController.h"
#import "NXDataModel.h"
#import "UIImageView+WebCache.h"

@interface NXCommentViewController ()

@end

@implementation NXCommentViewController {
    NXDataModel* _dataModel;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataModel = [[NXDataModel alloc] init];
    self.cmtTitle.text = self.selectedData[@"title"];
    self.cmtComment.text = self.selectedData[@"contents"];
    NSString * url;
    
    //URL을 통한 그림 삽입
    if(![[self.selectedData objectForKey:@"fileName"]  isEqual: @""])
    {
        url = @"http://localhost:8080/images/";
        url = [url stringByAppendingString:[self.selectedData objectForKey:@"fileName"]];
    } else {
        url = @"http://localhost:8080/images/noImageUploaded.png";
    }
    [self.cmtPhoto setImageWithURL:[NSURL URLWithString:url]];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
