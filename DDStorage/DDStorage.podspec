#
# Be sure to run `pod lib lint DDStorage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDStorage'
  s.version          = '0.1.2'
  s.summary          = 'A short description of DDStorage.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/syedqamara/DDStorage'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'syedqamara' => 'syedqamar.a1@gmail.com' }
  s.source           = { :git => 'https://github.com/dynamicdelivery/-ios-modules-sdk.git', :tag => 'DDStorage-v' + s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DDStorage/Classes/**/*'
  
   s.subspec 'Resources' do |resources|
       resources.resource_bundle = {'Database' => ['DDStorage/Assets/**/*{.*}']}
 end

  # s.resource_bundles = {
  #   'DDStorage' => ['DDStorage/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'MagicalRecord'
  s.dependency 'DDEncryption', '~> 0.1.0'
end
