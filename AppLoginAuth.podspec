#
# Be sure to run `pod lib lint AppLoginAuth.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppLoginAuth'
  s.version          = '0.1.2'
  s.summary          = 'A short description of AppLoginAuth.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/WZLYiOS/AppLoginAuth'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qiuqixiang' => '995386924@qq.com' }
  s.source           = { :git => 'https://github.com/WZLYiOS/AppLoginAuth.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.static_framework = true
  s.swift_version         = '5.0'
  s.requires_arc = true
  s.ios.deployment_target = '10.0'
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = 'AppLoginAuth/Classes/**/*'
  end
  
#  s.dependency 'GoogleSignIn', '>= 7.0.0'
  
  # s.resource_bundles = {
  #   'AppLoginAuth' => ['AppLoginAuth/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   
end
