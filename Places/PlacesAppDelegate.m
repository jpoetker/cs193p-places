//
//  PlacesAppDelegate.m
//  Places
//
//  Created by Jeff Poetker on 7/28/11.
//  Copyright 2011 Medplus, Inc. All rights reserved.
//

#import "PlacesAppDelegate.h"
#import "TopPlacesViewController.h"
#import "RecentPhotosViewController.h"

@implementation PlacesAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *placesNavController = [[UINavigationController alloc] init];
    TopPlacesViewController *topPlaces = [[TopPlacesViewController alloc] initWithStyle: UITableViewStylePlain ];
    [placesNavController pushViewController: topPlaces animated:NO];
    [topPlaces release];
    
    UINavigationController *recentNavController = [[UINavigationController alloc] init];
    RecentPhotosViewController *recentPhotos = [[RecentPhotosViewController alloc] initWithStyle:UITableViewStylePlain];
    [recentNavController pushViewController: recentPhotos animated:NO];
    [recentPhotos release];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects: placesNavController, recentNavController, nil];
    [placesNavController release]; [recentNavController release];

    self.viewController = tabBarController;
    [tabBarController release];

    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void) dealloc
{
    [_viewController release];
    [_window release];
    [super dealloc];
}
@end
