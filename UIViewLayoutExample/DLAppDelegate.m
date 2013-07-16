//
//  DLAppDelegate.m
//  UIViewLayoutExample
//
//  Created by Denis Lebedev on 15.07.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "DLAppDelegate.h"

#import "UIView+DLViewLayout.h"

@implementation DLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
	v.backgroundColor = [UIColor redColor];
	[[[v centerInSuperview] adjustOrigin:CGPointMake(20, 30)] adjustX:100];

	[self.window addSubview:v];

    [self.window makeKeyAndVisible];
	
	
    return YES;
}

@end
