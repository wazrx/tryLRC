//
//  AppDelegate.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWAppDelegate.h"
#import "XWSearchController.h"
#import "XWNavigationController.h"

@interface XWAppDelegate ()

@end

@implementation XWAppDelegate

#pragma mark - lazyLoding

- (UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    [_window makeKeyAndVisible];
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController = [[XWNavigationController alloc] initWithRootViewController:[XWSearchController new]];
    return YES;
}

@end
