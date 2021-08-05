Pod::Spec.new do |s|

  s.name         = "ZTLayout"
  s.version      = "0.0.1"
  s.summary      = "SnapKit 简单封装，并自定义操作符"

  s.homepage     = "https://github.com/zt-zhang/ZTLayout"
  s.author       = { "T_T" => "zt_zhang@protonmail.com" }
  s.source       = { :git => "https://github.com/zt-zhang/ZTLayout.git", :tag => s.version }
  
  s.platform     = :ios, "10.0"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source_files = "ZTLayout/ZTLayout/*.swift"
  s.framework    = "UIKit","Foundation"
  s.requires_arc = true

  s.dependency 'SnapKit'

end
