//
//  Photos.m
//  Places
//
//  Created by Jeff Poetker on 7/29/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import "Photos.h"
#import "TopPlaces.h"
#import "FlickrFetcher.h"

@interface Photos() 
+ (NSDictionary *) castToDictionaryOrNil: (id) photo;
+ (NSMutableArray *) loadRecentlyViewedPhotos;
@end

@implementation Photos

@synthesize photos;

- (id)init
{
    self = [super init];
    if (self) {
        self.photos = nil;
    }
    
    return self;
}

- (id)initWithPhotos: (NSArray *)somePhotos
{
    self = [self init];
    if (self) {
        self.photos = somePhotos;
    }
    return self;
}

- (NSUInteger) count
{
    return [photos count];
}

- (id) photoAtIndex:(NSUInteger)index
{
    return [[[photos objectAtIndex:index] copy] autorelease];
}

- (void) dealloc
{
    [photos release];
    [super dealloc];
}

+ (NSArray *) loadRecentlyViewedPhotos
{
    NSArray *loaded = [[NSUserDefaults standardUserDefaults] valueForKey: @"recentlyViewedPhotos"];
    return loaded;
}

+ (void) savePhotoAsViewed: (id) photo
{
    NSDictionary *dict = [Photos castToDictionaryOrNil: photo];
    
    if (dict) {
        NSMutableArray *viewed = [[Photos loadRecentlyViewedPhotos] mutableCopy];
        if (!viewed) {
            viewed = [[NSMutableArray alloc] initWithCapacity:1];
        }
        // if the photo is alread in the set, remove it to move it the top
        [viewed removeObject: dict];
        [viewed insertObject:dict atIndex:0];
        
        for (NSUInteger i = [viewed count] - 1; i > 50; i--) {
            [viewed removeObjectAtIndex: i];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue: viewed forKey:@"recentlyViewedPhotos"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [viewed release];
    }
}

+ (Photos *) photosRecentlyViewed
{
    Photos *photos = [[Photos alloc] initWithPhotos: [Photos loadRecentlyViewedPhotos]];
    return [photos autorelease];
}

+ (NSDictionary *) castToDictionaryOrNil: (id) photo
{
    if ([photo isKindOfClass:[NSDictionary class]]) {
        return photo;
    }
    return nil;
}

+ (NSString *) titleForPhoto:(id)photo
{
    return [[Photos castToDictionaryOrNil: photo] valueForKey:@"title"];
}

+ (NSString *)descriptionForPhoto:(id)photo
{
    return [[[Photos castToDictionaryOrNil: photo] valueForKey: @"description"] valueForKey: @"_content"];
}

+ (UIImage *)squareThumbnailForPhoto:(id)photo
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
    UIImage *image = [[[UIImage alloc] initWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:[Photos castToDictionaryOrNil: photo] format:FlickrFetcherPhotoFormatSquare]] autorelease];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    return image;
}
+ (UIImage *)largeImageForPhoto: (id)photo
{
    return [[[UIImage alloc] initWithData: [FlickrFetcher imageDataForPhotoWithFlickrInfo:[Photos castToDictionaryOrNil: photo] format:FlickrFetcherPhotoFormatLarge]] autorelease];
}

@end


@implementation PlacePhotos

@synthesize place;


- (id)init
{
    self = [super init];
    if (self) {
        self.place = nil;
    }
    
    return self;
}

- (id)initWithPlace: (id) aPlace
{
    self = [self init];
    if (self) {
        self.place = aPlace;
    }
    
    return self;
}

- (void)setPlace:(id) aPlace
{
    if (![[TopPlaces placeIdFromPlace:aPlace] isEqualToString:[TopPlaces placeIdFromPlace: place]]) {
        [place release];
        place = [aPlace retain];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        self.photos = [FlickrFetcher photosAtPlace: [TopPlaces placeIdFromPlace: aPlace]];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;        
    }
}


@end
