//
//  FlickrFetcherTests.h
//  Places
//
//  Created by Jeff Poetker on 7/28/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>

@interface FlickrFetcherTests : SenTestCase

- (void)testFetchTopPlaces;    // simple standalone test
- (void)testFetchPhotosAtPlace;
@end
