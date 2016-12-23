//
//  AppDelegate.m
//  ZITOPay
//
//  Created by 李冬冬 on 16/9/21.
//  Copyright © 2016年 ldd. All rights reserved.
//

#import "AppDelegate.h"
#import "ZITOPay.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [ZITOPay initWithZitoID:ZITOID appId:APPID andAppSecret:APPKEY sandbox:YES];
    
    //weichat
    [ZITOPay initWeChatPay:@"wx2a490909492ec841"];
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    return YES;
}
//ios9之前使用这个方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if (![ZITOPay handleOpenUrl:url]) {
        //handle其他类型的url
    }
    return YES;
}

//iOS9之后官方推荐用此方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    NSLog(@"options %@", options);
    if (![ZITOPay handleOpenUrl:url]) {
        //handle其他类型的url
    }
    return YES;
}
@end



