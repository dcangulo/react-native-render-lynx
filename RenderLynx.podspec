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

  s.source_files = "ios/**/*.{h,m,mm,cpp}"
  s.private_header_files = "ios/generated/**/*.h"

  # Use install_modules_dependencies helper to install the dependencies if React Native version >=0.71.0.
  # See https://github.com/facebook/react-native/blob/febf6b7f33fdb4904669f99d795eba4c0f95d7bf/scripts/cocoapods/new_architecture.rb#L79.
  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    s.dependency "React-Core"
  end

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
