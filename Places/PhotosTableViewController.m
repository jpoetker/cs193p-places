//
//  PhotosTableViewController.m
//  Places
//
//  Created by Jeff Poetker on 7/29/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "PhotoViewController.h"

@implementation PhotosTableViewController

@synthesize photos;
@synthesize savePhotoWhenSelected;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.photos = nil;
        self.savePhotoWhenSelected = YES;
    }
    return self;
}

- (id)initWithPhotos: (Photos *)somePhotos
{
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
        self.photos = somePhotos;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)setPhotos:(Photos *)somePhotos  
{
    [photos release];
    photos = [somePhotos retain];
    [self.view setNeedsDisplay];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    id photo = [photos photoAtIndex: indexPath.row];
    NSString *title = [Photos titleForPhoto:photo];
    NSString *description = [Photos descriptionForPhoto:photo];
    
    if ((title) && ([title length] > 0)) {
        cell.textLabel.text = title;
        if ((description) && ([description length] > 0)) {
            cell.detailTextLabel.text = description;
        } else {
            cell.detailTextLabel.text = nil;
        }
    } else if ((description) && ([description length] > 0)) {
        cell.textLabel.text = description;
        cell.detailTextLabel.text = nil;
    } else {
        cell.textLabel.text = @"Unknown";
        cell.detailTextLabel.text = nil;
    }
    cell.imageView.image = [Photos squareThumbnailForPhoto:photo];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id photo = [photos photoAtIndex: indexPath.row];

    if (self.savePhotoWhenSelected) [Photos savePhotoAsViewed:photo];
    
    PhotoViewController *photoController = [[PhotoViewController alloc] initWithNibName:nil bundle:nil];
    photoController.photo = photo;
    photoController.title = [tableView cellForRowAtIndexPath: indexPath].textLabel.text;
    
    [self.navigationController pushViewController:photoController animated:YES];
    [photoController release];
    
}

@end

@implementation RecentPhotosViewController
- (void) setup
{
    UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:0];
    tabItem.title = @"Most Recent";
    
    self.tabBarItem = tabItem;
    self.savePhotoWhenSelected = NO;
    [tabItem release];
}

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.photos = [Photos photosRecentlyViewed];
    [super viewWillAppear:animated];
}

@end
