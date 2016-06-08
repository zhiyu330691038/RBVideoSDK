

Pod::Spec.new do |s|
  s.name             = 'RBVideoSDK'
  s.version          = '1.1.0'
  s.summary          = '北京智能管家视频sdk.'

  s.platform = :ios, "9.0"

  s.description      = <<-DESC
TODO: 北京智能管家视频sdk.
                       DESC
  s.requires_arc    = true

  s.homepage         = 'https://github.com/zhiyu330691038/RBVideoSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhikuiyu' => 'zky_416@sina.com' }
  s.source           = { :git => 'https://github.com/zhiyu330691038/RBVideoSDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'RBVideoSDK/Classes/**/*'

  s.resource_bundles = {
    'RBVideoSDK' => ['RBVideoSDK/Assets/*.*']
  }
  s.vendored_libraries = 'RBVideoSDK/Assets/*.a'
  s.libraries = 'icucore','bz2','z','c++','iconv'
  s.frameworks = 'UIKit', 'MapKit','AVFoundation','AVKit','WebKit','AudioToolBox','MediaPlayer','OpenGLES','VideoToolBox','GLKit','SystemConfiguration','CoreMedia','CoreVideo','MobileCoreServices'
end
