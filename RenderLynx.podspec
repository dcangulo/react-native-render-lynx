require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "RenderLynx"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :git => "https://github.com/dcangulo/react-native-render-lynx.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift,cpp}"

  if ENV["RCT_NEW_ARCH_ENABLED"] == nil || ENV["RCT_NEW_ARCH_ENABLED"] != "1"
    s.exclude_files = "ios/RNRenderLynxViewSpec"
  end

  install_modules_dependencies(s)

  s.dependency 'Lynx/Framework', '3.2.0-rc.0'

  s.dependency 'PrimJS/quickjs', '2.11.1-rc.0'
  s.dependency 'PrimJS/napi', '2.11.1-rc.0'

  # integrate image-service, log-service, and http-service
  s.dependency 'LynxService/Image', '3.2.0-rc.0'
  s.dependency 'LynxService/Log', '3.2.0-rc.0'
  s.dependency 'LynxService/Http', '3.2.0-rc.0'

  # ImageService dependencies:
  s.dependency 'SDWebImage','5.15.5'
  s.dependency 'SDWebImageWebPCoder', '0.11.0'
end
