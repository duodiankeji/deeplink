//
//  AdmoreSDKDeepLink.h
//  Pods
//
//  Created by mkoo on 2017/1/11.
//
//

#import <Foundation/Foundation.h>

@interface AdmoreSDKDeepLink : NSObject

//初始化appId和appKey
+ (void) setAppId:(NSString*)appKey appKey:(NSString*)appKey;

//处理scheme
+ (BOOL) handleUrl:(NSURL*)url;

@end
