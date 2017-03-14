//
//  AMAppDelegate.m
//  AdmoreSDKDeepLink
//
//  Created by wanglin.sun on 01/11/2017.
//  Copyright (c) 2017 wanglin.sun. All rights reserved.
//

#import "AMAppDelegate.h"
#import "AdmoreSDKDeepLink.h"
#import "WebViewController.h"

@implementation AMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AdmoreSDKDeepLink setAppId:@"am888888" appKey:@"key888888"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    //NOTE: 方案一／方案二 选其一即可
    
    //方案一：用webview打开试客落地页
    NSString *broserHeader = @"am888888://browser?url=";
    
    if([url.absoluteString hasPrefix:broserHeader]) {
        
        NSString *urlParam = [url.absoluteString substringFromIndex:broserHeader.length];
        urlParam = [urlParam stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        WebViewController *vc = [WebViewController new];
        vc.url = urlParam;
        
        UIViewController *rootVc = self.window.rootViewController;
        if([rootVc isKindOfClass:[UINavigationController class]]) {
            [((UINavigationController*)rootVc) pushViewController:vc animated:YES];
        } else {
            [rootVc presentViewController:vc animated:YES completion:nil];
        }
        return YES;
    }
    
    //方案二：发送数据给试客服务器
    if( [AdmoreSDKDeepLink handleUrl:url] ) {
        return YES;
    }
    //处理您的其他逻辑
    return NO;
    
    //或者直接 return [AdmoreSDKDeepLink handleUrl:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [self application:application openURL:url options:@{}];
}

- (IBAction)close:(id)sender {
    
}

@end
