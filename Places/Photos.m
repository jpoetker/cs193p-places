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
    return [photos objectAtIndex:index];
}

+ (NSDictionary *) photo: (id) photo
{
    if ([photo isKindOfClass:[NSDictionary class]]) {
        return photo;
    }
    return nil;
}

+ (NSString *) titleForPhoto:(id)photo
{
    return [[Photos photo: photo] valueForKey:@"title"];
}

+ (NSString *)descriptionForPhoto:(id)photo
{
    return [[[Photos photo: photo] valueForKey: @"description"] valueForKey: @"_content"];
}

+ (UIImage *)squareThumbnailForPhoto:(id)photo
{
    return [[[UIImage alloc] initWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:[Photos photo: photo] format:FlickrFetcherPhotoFormatSquare]] autorelease];
}
+ (UIImage *)largeImageForPhoto: (id)photo
{
    return [[[UIImage alloc] initWithData: [FlickrFetcher imageDataForPhotoWithFlickrInfo:[Photos photo: photo] format:FlickrFetcherPhotoFormatLarge]] autorelease];
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
    
        self.photos = [FlickrFetcher photosAtPlace: [TopPlaces placeIdFromPlace: aPlace]];
    }
}


@end
