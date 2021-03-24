#
# Be sure to run `pod lib lint DDAnalytics.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDAnalytics'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDAnalytics.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/etDev24/DDAuth'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'etDev24' => 'et_dev24@ThedynamicdeliveryMe.com' }
    s.source           = { :git => 'https://github.com/etDev24/DDAuth.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '10.0'

    s.source_files = 'DDAnalytics/Classes/**/*.[^xib]*'
    s.subspec 'Resources' do |resources|
        resources.resource_bundle = {'Images' => ['DDAnalytics/Assets/**/*.{xcassets,png,gif}'],'Jsons' => ['DDAnalytics/Assets/Jsons/**/*.{json,png}'],'Nibs' => ['DDAnalytics/Classes/**/*.{xib}']}
    end
    # s.resource_bundles = {
    #   'DDAuth' => ['DDAuth/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
  #  s.dependency 'DDUI', '~> 0.1.0'
    s.dependency 'DDModels', '~> 0.1.0'
    s.dependency 'DDStorage', '~> 0.1.0'
    s.dependency 'DDNetwork', '~> 0.1.0'
    s.dependency 'JSONModel'
  #  s.dependency 'NimbusKit-AttributedLabel'

  end
