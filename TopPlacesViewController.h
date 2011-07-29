//
//  TopPlacesViewController.h
//  Places
//
//  Created by Jeff Poetker on 7/28/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopPlaces.h"
#import "PhotosTableViewController.h"

@interface TopPlacesViewController : UITableViewController
{
    @private
    TopPlaces *topPlaces;
}

@property (retain, nonatomic) TopPlaces *topPlaces;
@end
