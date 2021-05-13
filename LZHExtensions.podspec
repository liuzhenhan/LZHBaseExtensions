Pod::Spec.new do |s|
s.name         = "LZHExtensions"
s.version      = "1.0.5"
s.license = { :type => "MIT", :file => "LICENSE" }
s.summary      = "新增获取位置以及逆地理编码获取省市及经纬度"
s.homepage     = "https://github.com/liuzhenhan/LZHBaseExtensions"
s.author             = { "liuzhenhan" => "497108685@qq.com" }
s.source       = { :git => "https://github.com/liuzhenhan/LZHBaseExtensions.git", :tag => s.version }
s.platform     = :ios, "10.0"
s.source_files  = "LZHExtensions"

s.frameworks = "Foundation", "UIKit"
s.swift_version='5.0'
end
