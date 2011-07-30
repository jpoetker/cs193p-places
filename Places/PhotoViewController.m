//
//  PhotoViewController.m
//  Places
//
//  Created by Jeff Poetker on 7/29/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import "PhotoViewController.h"
#import "Photos.h"



@implementation PhotoViewController

@synthesize scrollView, imageView;
@synthesize photo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.photo = nil;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)setPhoto:(id)aPhoto
{
    [photo release];
    photo = [aPhoto retain];
    
    UIImage *image = [Photos largeImageForPhoto:photo];
    self.imageView = [[[UIImageView alloc] initWithImage: image] autorelease];
    [self.scrollView addSubview: self.imageView];
    
    self.scrollView.contentSize = image.size;
    
    [self.view setNeedsDisplay];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
    sv.minimumZoomScale = 0.3;
    sv.maximumZoomScale = 3.0;
    sv.delegate = self;
    
    self.scrollView = sv;
    self.view = sv;
    [sv release];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)sender
{
    return self.imageView;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)dealloc
{
    [scrollView release];
    [photo release];
    [imageView release];
    [super dealloc];
}
@end
