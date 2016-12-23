Pod::Spec.new do |s|
s.name             = 'SNPaySDKLib'
s.version          = '1.1.1'
s.summary          = 'ZITOPaySDK iOS SDK'
s.description      = <<-DESC
融拓支付聚合平台
轻松接入,开启支付新里程
DESC

s.homepage         = 'http://www.rtkj.com.cn'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'sunnymoteng' => '369074420@qq.com' }
s.source           = { :git => 'https://github.com/sunnymoteng/SNPaySDKLib.git', :tag => s.version.to_s }
s.ios.deployment_target = '8.0'
s.default_subspec = 'BaseCore', 'Alipay'


s.subspec 'BaseCore' do |BaseCore|
BaseCore.frameworks = 'CFNetwork', 'SystemConfiguration', 'Security'
BaseCore.ios.library = 'c++', 'stdc++', 'z'
BaseCore.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

s.subspec 'Alipay' do |ss|
ss.vendored_libraries = 'lib/Channels/Alipay/*.a'
ss.ios.vendored_frameworks = 'lib/Channels/Alipay/AlipaySDK.framework'
ss.resource = 'lib/Channels/Alipay/AlipaySDK.bundle'
ss.frameworks = 'CoreMotion', 'CoreTelephony'
ss.dependency 'SNPaySDKLib/BaseCore'
end

end
