#
# Be sure to run `pod lib lint DDFilters.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDFilters'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDFilters.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/etDev24/DDFilters'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'etDev24' => 'et_dev24@TheEntertainerMe.com' }
  s.source           = { :git => 'https://github.com/etDev24/DDFilters.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DDFilters/Classes/**/*'
  s.subspec 'Resources' do |resources|
      resources.resource_bundle = {'Images' => ['DDFilters/Assets/**/*.{xcassets,png,gif}'],'Jsons' => ['DDFilters/Assets/Jsons/**/*.{json,png}'],'Nibs' => ['DDFilters/**/*.{xib}']}
  end
  # s.resource_bundles = {
  #   'DDCommons' => ['DDCommons/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'DDCommons', '~> 0.1.0'
  s.dependency 'DDConstants', '~> 0.1.0'
  s.dependency 'DDUI', '~> 0.1.0'
end
