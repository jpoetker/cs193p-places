//
//  TopPlaces.m
//  Places
//
//  Created by Jeff Poetker on 7/28/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import "TopPlaces.h"
#import "FlickrFetcher.h"

@implementation TopPlaces

@synthesize places;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSArray *)places
{
    if (!places) {
        NSArray *fetchedPlaces = [FlickrFetcher topPlaces];
        // sort the results by title
        places = [fetchedPlaces sortedArrayUsingDescriptors: 
                  [NSArray arrayWithObjects:
                   [NSSortDescriptor sortDescriptorWithKey:@"_content" ascending:YES],nil]];
        [places retain];
    }
    return places;
}

- (void)dealloc
{
    [places release];
    [super dealloc];
}

- (id) placeAtIndex: (NSUInteger) index
{
    return [places objectAtIndex: index];
}

- (PlacePhotos *) photosForPlaceAtIndex: (NSUInteger) index
{
    return [[[PlacePhotos alloc] initWithPlace: [self placeAtIndex: index]] autorelease];
}

+ (NSDictionary *) place: (id) place
{
    if ([place isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *) place;
    } 
    return nil;
}

+ (NSArray *)descriptionComponentsFromPlace: (id)place
{
    return [[[TopPlaces place: place] valueForKey:@"_content"] componentsSeparatedByString:@","];
}

+ (NSString *)placeIdFromPlace: (id)place
{
    return [[TopPlaces place: place] valueForKey:@"place_id"];
}

+ (NSString *)cityFromPlace: (id)place 
{
    NSArray *desc = [TopPlaces descriptionComponentsFromPlace:place];
//    NSLog(@"%@", [desc objectAtIndex:0]);
    return [desc objectAtIndex: 0];
}
+ (NSString *)cityLocationFromPlace:(id)place
{
    NSArray *desc = [TopPlaces descriptionComponentsFromPlace:place];
    NSRange range;
    range.location = 1;
    range.length = [desc count] - 1;
    NSArray *locDesc = [desc subarrayWithRange:range];
    
    NSString *location = [locDesc componentsJoinedByString: @","];
    NSLog(@"%@", location);
    return location;
}
         
@end
