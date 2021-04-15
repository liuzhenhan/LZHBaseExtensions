Pod::Spec.new do |s|
s.name         = "LZHExtensions"
s.version      = "1.0.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.summary      = "这是一个工具类"
s.homepage     = "https://github.com/liuzhenhan/LZHBaseExtensions"
s.author             = { "liuzhenhan" => "497108685@qq.com" }
s.source       = { :git => "https://github.com/liuzhenhan/LZHBaseExtensions.git", :tag => s.version }
s.platform     = :ios, "13.0"
     s.source_files  = "LZHExtensions"

s.frameworks = "Foundation", "UIKit"
s.swift_version='5.0'
end
