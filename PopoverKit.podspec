#
#  Be sure to run `pod spec lint PopoverKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "PopoverKit"
  s.version      = "0.1.0"
  s.summary      = "A lightweight, swift library for pop your viewcontroll."
  s.homepage     = "https://github.com/ZionChang/PopoverKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "archerzz" => "archerzz.work@gmail.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/ZionChang/PopoverKit.git", :tag => s.version }
  s.source_files  = "Sources/*.swift"
  s.requires_arc = true
  s.framework = "UIKit"

end
