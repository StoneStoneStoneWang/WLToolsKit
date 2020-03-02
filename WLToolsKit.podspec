
Pod::Spec.new do |spec|
  
  spec.name         = "WLToolsKit"
  spec.version      = "1.3.2"
  spec.summary      = "A Lib For Tool."
  spec.description  = <<-DESC
  WLToolKit是一个综合类的工具类。 字符串、颜色 图片等 Load+Swizzling
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/WLToolsKit"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10。0"
  
  spec.swift_version = '5.0'
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/WLToolsKit.git", :tag => "#{spec.version}" }
  
  spec.subspec 'String' do |str|
    
    str.source_files = "Code/String/*.{swift}"
    
  end
  spec.subspec 'Common' do |common|
    
    common.source_files = "Code/Common/*.{swift}"
    
    common.dependency 'WLToolsKit/Date'
  end
  spec.subspec 'Color' do |color|
    
    color.source_files = "Code/Color/*.{swift}"
    color.dependency 'WLToolsKit/String'
  end
  spec.subspec 'Image' do |image|
    
    image.source_files = "Code/Image/*.{swift}"
    image.dependency 'WLToolsKit/Color'
    image.dependency 'WLToolsKit/Common'
  end
  
  spec.subspec 'NaviBar' do |bar|
    
    bar.source_files = "Code/NaviBar/*.{swift}"
  end
  spec.subspec 'JsonCast' do |cast|
    
    cast.source_files = "Code/JsonCast/*.{swift}"
  end
  
  spec.subspec 'AppStore' do |store|
    
    store.source_files = "Code/AppStore/*.{swift}"
    store.dependency 'WLToolsKit/OpenUrl'
  end
  spec.subspec 'Date' do |date|
    
    date.source_files = "Code/Date/*.{swift}"
    
  end
  spec.subspec 'DeviceInfo' do |info|
    
    info.source_files = "Code/DeviceInfo/*.{swift}"
    info.dependency 'WLToolsKit/Common'
  end
  spec.subspec 'OpenUrl' do |open|
    
    open.source_files = "Code/OpenUrl/*.{swift}"
  end
  spec.subspec 'Then' do |th|
    
    th.source_files = "Code/Then/*.{swift}"
  end
  spec.subspec 'Swizzling' do |swizzle|
    
    swizzle.source_files = "Code/Swizzling/*.{swift}"
  end
end


