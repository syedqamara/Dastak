#
# Be sure to run `pod lib lint DDCommons.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDCommons'
  s.version          = '0.1.8'
  s.summary          = 'A short description of DDCommons.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/etDev24/DDCommons'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'etDev24' => 'et_dev24@ThedynamicdeliveryMe.com' }
  s.source           = { :git => 'https://github.com/dynamicdelivery/-ios-modules-sdk.git', :tag => 'DDCommons-v'+String(s.version)
  }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.source_files = 'DDCommons/Classes/**/*'
  s.subspec 'Resources' do |resources|
      resources.resource_bundle = {'DDLocalizedStrings' => ['DDCommons/Assets/**/*.{strings}']}
  end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'JSONModel', '~> 1.8.0'
  s.dependency 'DDConstants', '~> 0.1.92'
  s.dependency 'SDWebImage', '~> 5.1.0'
  s.dependency 'NSDate+TimeAgo'
#  s.dependency 'DDLottie', '~> 0.1.0'
  s.dependency  'lottie-ios', '2.5.3'
  s.dependency 'JNKeychain'
  s.dependency 'JWT'
  s.dependency 'DeviceUtil'
  s.dependency 'IQKeyboardManager' #iOS8 and later
  s.dependency 'ChameleonFramework'

end
