
Pod::Spec.new do |spec|
  
  spec.name         = "WLToolsKit"
  spec.version      = "1.3.0"
  spec.summary      = "A Lib For Tool."
  spec.description  = <<-DESC
  WLToolKit是一个综合类的工具类。 字符串、颜色 图片等 Load+Swizzling
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/WLToolsKit"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "9.0"
  spec.ios.deployment_target = "9.0"
  
  spec.swift_version = '5.0'
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/WLToolsKit.git", :tag => "#{spec.version}" }
  
  spec.subspec 'WLString' do |str|
    
    str.source_files = "Code/String/*.{swift}"
    
  end
  spec.subspec 'WLCommon' do |common|
    
    common.source_files = "Code/Common/*.{swift}"
    
    common.dependency 'WLToolsKit/WLDate'
  end
  spec.subspec 'WLColor' do |color|
    
    color.source_files = "Code/Color/*.{swift}"
    color.dependency 'WLToolsKit/WLString'
  end
  spec.subspec 'WLImage' do |image|
    
    image.source_files = "Code/Image/*.{swift}"
    image.dependency 'WLToolsKit/WLColor'
    image.dependency 'WLToolsKit/WLCommon'
  end
  
  spec.subspec 'WLNaviBar' do |bar|
    
    bar.source_files = "Code/NaviBar/*.{swift}"
    
  end
  spec.subspec 'WLJsonCast' do |cast|
    
    cast.source_files = "Code/JsonCast/*.{swift}"
    
  end
  
  spec.subspec 'WLAppStore' do |store|
    
    store.source_files = "Code/AppStore/*.{swift}"
    store.dependency 'WLToolsKit/WLOpenUrl'
  end
  spec.subspec 'WLDate' do |date|
    
    date.source_files = "Code/Date/*.{swift}"
    
  end
  spec.subspec 'WLDeviceInfo' do |info|
    
    info.source_files = "Code/DeviceInfo/*.{swift}"
    info.dependency 'WLToolsKit/WLCommon'
  end
  spec.subspec 'WLOpenUrl' do |open|
    
    open.source_files = "Code/OpenUrl/*.{swift}"
    
  end
  spec.subspec 'WLThen' do |th|
    
    th.source_files = "Code/Then/*.{swift}"
    
  end
  spec.subspec 'WLSwizzling' do |swizzle|
    
    swizzle.source_files = "Code/Swizzling/*.{swift}"
    
  end
end


