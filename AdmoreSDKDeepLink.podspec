Pod::Spec.new do |s|
  s.name             = 'AdmoreSDKDeepLink'
  s.version          = '0.1.0'
  s.summary          = 'AdmoreSDKDeepLink SDK on ios'
  s.homepage         = 'https://github.com/duodiankeji/deeplink'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wanglin.sun' => 'mkoosun@gmail.com' }
  s.source           = { :git => 'https://github.com/duodiankeji/deeplink.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'AdmoreSDKDeepLink/Classes/**/*'
  s.frameworks = 'Foundation'
end
