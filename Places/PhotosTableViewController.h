//
//  PhotosTableViewController.h
//  Places
//
//  Created by Jeff Poetker on 7/29/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photos.h"

@interface PhotosTableViewController : UITableViewController
{
    Photos *photos;
    BOOL savePhotoWhenSelected;
}
- (id)initWithPhotos: (Photos *)somePhotos;

@property (nonatomic, retain) Photos *photos;
@property BOOL savePhotoWhenSelected;

@end

@interface RecentPhotosViewController : PhotosTableViewController

@end