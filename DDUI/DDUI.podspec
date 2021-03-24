#
# Be sure to run `pod lib lint DDUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/etDev24/DDUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'etDev24' => 'et_dev24@ThedynamicdeliveryMe.com' }
  s.source           = { :git => 'https://github.com/etDev24/DDUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DDUI/Classes/**/*.[^xib]*'
  s.subspec 'Resources' do |resources|
      resources.resource_bundle = {'Images' => ['DDUI/Assets/**/*.{xcassets,png,gif}'],'Jsons' => ['DDUI/Assets/Jsons/**/*.{json,png}'],'Nibs' => ['DDUI/**/*.{xib}'],'Htmls' => ['DDUI/Assets/Templates/**/*.{html,css}']}
  end
  # s.resource_bundles = {
  #   'DDUI' => ['DDUI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.static_framework = true
#  s.pod_target_xcconfig = {
#    "OTHER_LDFLAGS" => '$(inherited) -framework "GoogleMaps" -framework "GooglePlaces" -framework "GoogleMapsBase"',
#    "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => 'YES',
#    "FRAMEWORK_SEARCH_PATHS" => '$(inherited) "${PODS_ROOT}/GoogleMaps/Maps/Frameworks" "${PODS_ROOT}/GooglePlaces/Frameworks" "${PODS_ROOT}/GoogleMaps/Base/Frameworks"',
#  }
  s.dependency 'DDCommons', '~> 0.1.0'
  s.dependency 'DDConstants', '~> 0.1.0'
  s.dependency 'DDAnalytics', '~> 0.1.0'
  s.dependency 'SDWebImage', '~> 5.1.0'
  s.dependency 'RestKit','0.27.2'
  s.dependency 'LSAnimator', '2.1.4'
  s.dependency 'HWPanModal'
  s.dependency 'PBJNetworkObserver'
  s.dependency 'TYCyclePagerView'
  s.dependency 'VBPieChart'
  s.dependency 'OTPTextField'
  s.dependency 'MGSwipeTableCell'
  s.dependency 'HCSStarRatingView'
  
end
