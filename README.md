# ItrySDK 使用说明
***

## 说明
1. appID：app在《多点广告开放平台》的唯一ID

2. appKey：为了避免您的appID暴露，使用appKey用户交互

3. scheme头：《多点广告开放平台》分配，比如`itry1234://`，需要在app的工程文件的`URL Types`项里添加: `identifier`: `itry`，`URL Schemes`: `itry1234 `

4. idfa：sdk中使用了idfa，请在提交appstore审核时注意

## 使用方法
1. 将ItrySDK.h 和 ItrySDK.m放入工程，

2. 或者使用Pod安装方式：pod 'ItrySDK', :git => 'https://github.com/duodiankeji/deeplink.git'

3. 在您的AppDelegate中override `application:openURL:options:`方法，调用ItrySDK的`handleUrl:withAppId:`:

```
- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    if( [ItrySDK handleUrl:url withAppkey:@"1234"] ) {
        return YES;
    }
    //处理您的其他逻辑
    return NO;
}

```
如果您的app只支持ios9(含)以上版本，只需添加以上函数即可。如果需要支持ios9以下，则`application:handleOpenURL:`也需要处理

```
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    if( [ItrySDK handleUrl:url withAppkey:@"1234"] ) {
        return YES;
    }
    //处理您的其他逻辑
    return NO;
}
```
## 流程
![](Sequence.png)

## Author

mkoo, wanglin.sun@duodian.com

## License

Copyright © 2017 北京多点科技股份有限公司. All Rights Reserved
