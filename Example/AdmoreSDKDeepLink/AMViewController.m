//
//  AMViewController.m
//  AdmoreSDKDeepLink
//
//  Created by wanglin.sun on 01/11/2017.
//  Copyright (c) 2017 wanglin.sun. All rights reserved.
//

#import "AMViewController.h"

@interface AMViewController ()

@end

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)actionJump:(id)sender {
    
    NSString *urlParam = @"https://am.admore.com.cn/deeplink/info/test";
    urlParam = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)urlParam,NULL,CFSTR(":/?#[]@!$&’()*+,;="),kCFStringEncodingUTF8));
    urlParam = [NSString stringWithFormat:@"am888888://browser?url=%@", urlParam];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlParam] options:@{} completionHandler:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
