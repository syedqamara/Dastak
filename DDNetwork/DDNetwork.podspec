#
# Be sure to run `pod lib lint DDNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDNetwork'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDNetwork.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/etDev24/DDNetwork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'etDev24' => 'et_dev24@ThedynamicdeliveryMe.com' }
  s.source           = { :git => 'https://github.com/dynamicdelivery/dynamicdelivery-IOS.git', :tag => 'DDNetwork-v' + s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DDNetwork/Classes/**/*'
  
  s.dependency 'DDModels', '~> 0.1.0'
  s.dependency 'DDEncryption', '~> 0.1.0'

  # s.resource_bundles = {
  #   'DDNetwork' => ['DDNetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
