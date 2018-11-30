
Pod::Spec.new do |s|

s.name         = "TSToolKit_Swift"
s.version      = "1.1.3"
s.summary      = "A Lib For Tool."
s.description  = <<-DESC
TSToolKit_Swift是一个综合类的工具类。 字符串、颜色 图片等 Load+Swizzling
DESC

s.homepage     = "https://github.com/StoneStoneStoneWang/TSToolKit_Swift"
s.license      = { :type => "MIT", :file => "LICENSE.md" }
s.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
s.platform     = :ios, "9.0"
s.ios.deployment_target = "9.0"

s.swift_version = '4.2'

s.frameworks = 'UIKit', 'Foundation'

s.source = { :git => "https://github.com/StoneStoneStoneWang/TSToolKit_Swift.git", :tag => "#{s.version}" }

s.source_files = "Code/**/*.{swift}"

end


