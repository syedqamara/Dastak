#
# Be sure to run `pod lib lint DDRedemptionsUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDRedemptionsUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDRedemptionsUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/zubair-ets/DDRedemptionsUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zubair-ets' => 'et_dev42@theentertainerme.com' }
  s.source           = { :git => 'https://github.com/zubair-ets/DDRedemptionsUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

   s.source_files = 'DDRedemptionsUI/Classes/**/*.[^xib]*'
   s.subspec 'Resources' do |resources|
       resources.resource_bundle = {'Images' => ['DDRedemptionsUI/Assets/**/*.{xcassets,png,gif}'],'Jsons' => ['DDRedemptionsUI/Assets/Jsons/**/*.{json,png}'],'Nibs' => ['DDRedemptionsUI/Classes/**/*.{xib}']}
    # s.resource_bundles = {
    #   'DDRedemptionsUI' => ['DDRedemptionsUI/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
  end

  s.dependency 'DDRedemptions', '~> 0.1.0'
  s.dependency 'DDSlideToUnlock'
  s.dependency 'DDSocial', '~> 0.1.0'
  
  end

