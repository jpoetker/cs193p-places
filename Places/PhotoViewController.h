//
//  PhotoViewController.h
//  Places
//
//  Created by Jeff Poetker on 7/29/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    id photo;
    UIImageView *imageView;
}

@property (retain) UIScrollView *scrollView;
@property (retain) UIImageView *imageView;
@property (retain, nonatomic) id photo;



@end
