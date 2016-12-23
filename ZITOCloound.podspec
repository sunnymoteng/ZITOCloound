Pod::Spec.new do |s|
s.name             = 'ZITOCloound'
s.version          = '3.3.3'
s.summary          = 'ZITOCloound iOS SDK'
s.description      = <<-DESC
融拓支付聚合平台
轻松接入,开启支付新里程
DESC

s.homepage         = 'http://www.rtkj.com.cn'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'sunnymoteng' => '369074420@qq.com' }
s.source           = { :git => 'https://github.com/sunnymoteng/ZITOCloound.git', :tag => s.version.to_s }
s.ios.deployment_target = '8.0'
s.default_subspec = 'BaseCore', 'Alipay'


s.subspec 'BaseCore' do |core|
core.frameworks = 'CFNetwork', 'SystemConfiguration', 'Security'
core.ios.library = 'c++', 'stdc++', 'z'
core.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

s.subspec 'Alipay' do |ss|
ss.vendored_libraries = 'lib/Channels/Alipay/*.a'
ss.ios.vendored_frameworks = 'lib/Channels/Alipay/AlipaySDK.framework'
ss.resource = 'lib/Channels/Alipay/AlipaySDK.bundle'
ss.frameworks = 'CoreMotion', 'CoreTelephony'
ss.dependency 'ZITOCloound/BaseCore'
end

end
