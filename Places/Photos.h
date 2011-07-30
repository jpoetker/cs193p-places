//
//  Photos.h
//  Places
//
//  Created by Jeff Poetker on 7/29/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photos : NSObject
{
    NSArray *photos;
    NSMutableArray *viewed;
}

@property (nonatomic, retain) NSArray *photos;
@property (readonly) NSArray *recentlyViewedPhotos;

- (NSUInteger) count;
- (id) photoAtIndex: (NSUInteger) index;
- (void) savePhotoAsViewed: (id) photo;

+ (NSString *) titleForPhoto: (id) photo;
+ (NSString *) descriptionForPhoto: (id) photo;
+ (UIImage *) squareThumbnailForPhoto: (id) photo;
+ (UIImage *)largeImageForPhoto: (id)photo;
@end


@interface PlacePhotos : Photos
{
    id place;
}

- (id) initWithPlace: (id) aPlace;

@property (nonatomic, retain) id place;

@end
