//
//  AdmoreSDK.m
//  Pods
//
//  Created by mkoo on 2017/1/11.
//
//

#import "AdmoreSDK.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

#define THOST @"https://itry.com/admoresdkdeeplink/info"

@implementation AdmoreSDK

#pragma mark - public

//处理scheme
+ (BOOL) handleUrl:(NSURL*)url withAppkey:(NSString*)appkey {
    
    if([url.absoluteString hasPrefix:@"itry"]) {
        
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *bundleId = [[NSBundle mainBundle]bundleIdentifier];
        
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:url.absoluteString forKey:@"url"];
        if(idfa) {
            [params setObject:idfa forKey:@"idfa"];
        }
        
        long long time = (long long)[NSDate date].timeIntervalSince1970;
        
        NSString *key = [NSString stringWithFormat:@"%@?a=%@&t=%lld", THOST, appkey, time];
        
        key = [AdmoreSDK md5:key];
        
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        
        NSData *encryptData = [AdmoreSDK data_aes256_encrypt:jsonData key:key];
        
        NSString *info = [AdmoreSDK data_to_string:encryptData];
        
        NSString *address = [NSString stringWithFormat:@"%@?a=%@&t=%lld&i=%@", THOST, appkey, time, info];
        
        [AdmoreSDK requestWithUrl:[NSURL URLWithString:address] reset:YES];
        
        return YES;
    }
    
    return NO;
}

//发送信息给试客，如未成功会重试最多10次
+ (void) requestWithUrl: (NSURL*) url reset:(BOOL)reset {
    
    static BOOL g_success = NO;
    static NSInteger g_requestTimes = 0;
    if(reset) {
        g_success = NO;
        g_requestTimes = 0;
    }
    
    if(g_success)
        return;
    
    dispatch_queue_t queue = dispatch_queue_create("com.duodian.admoresdk", NULL);
    
    dispatch_async(queue, ^{
        
        if(g_success)
            return;
        
        NSError *error;
        
        NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        
        BOOL success = NO;
        
        if(error) {
            success = NO;
        } else if(result.length>0) {
            success = [result boolValue];
        }
        
        if(success)
            g_success = success;
        
        if(g_success)
            return;
        
        if(!success && g_requestTimes < 10) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [AdmoreSDK requestWithUrl:url reset:NO];
            });
        }
        
        g_requestTimes++;
    });
    
    //dispatch_release(queue);
}

#pragma mark - util

+ (NSString*)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,
           (unsigned int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//转换为2进制NSString
+ (NSString *) data_to_string:(NSData*)data {
   
    if (data && data.length > 0) {
        
        Byte *datas = (Byte*)[data bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:data.length * 2];
        for(int i = 0; i < data.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

//aes加密
+ (NSData *)data_aes256_encrypt:(NSData*)data key:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

@end
