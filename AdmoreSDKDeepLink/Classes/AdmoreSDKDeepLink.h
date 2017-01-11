//
//  AdmoreSDKDeepLink.h
//  Pods
//
//  Created by mkoo on 2017/1/11.
//
//

#import <Foundation/Foundation.h>

@interface AdmoreSDKDeepLink : NSObject

//处理scheme
+ (BOOL) handleUrl:(NSURL*)url withAppkey:(NSString*)appkey;

@end
