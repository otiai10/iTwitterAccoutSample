//
//  TwitterAccoutSampleAppDelegate.m
//  iTwitterAccoutSample
//
//  Created by otiai10 on 2014/08/09.
//  Copyright (c) 2014年 otiai10. All rights reserved.
//

#import "TwitterAccoutSampleAppDelegate.h"

// (1) importしまーす
#import <Accounts/Accounts.h>

@implementation TwitterAccoutSampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    // (2) とりあえずここに書いちゃおう
    ACAccountStore *store = [ACAccountStore new];
    ACAccountType *type = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    // optionsって何渡せばいいか分からんので、とりあえず空のやつでいいや
    // NSDictionary *options = @{};
    // しらべた感じ、何も要らないならnilを渡せって言われた
    
    // (3) ユーザに許可要求する
    [store requestAccessToAccountsWithType:type options:nil completion:^(BOOL granted, NSError *error) {
        if (! granted) {
            NSLog(@"%@", error);
            return;
        }
        // (4) 許可されたので、取得する
        NSArray *accounts = [store accountsWithAccountType:type];
        // (5) 許可されたけど、無かったりして
        if (accounts.count < 1) {
            return;
        }
        // (6) とりあえず最初のやつで
        ACAccount *account = accounts[0];
        NSLog(@"取得できたやつ %@", NSStringFromClass([account class]));
        NSLog(@"ユーザネーム? %@", [account username]);
        NSLog(@"ユーザID? %@", [[account valueForKey:@"properties"] objectForKey:@"user_id"]);
        return;
    }];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
