#
# Be sure to run `pod lib lint DDCashless.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDCashless'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDCashless.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/etDev24/DDCashless'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'etDev24' => 'et_dev24@TheEntertainerMe.com' }
  s.source           = { :git => 'https://github.com/etDev24/DDCashless.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'


    s.ios.deployment_target = '10.0'

      s.source_files = 'DDCashless/Classes/**/*.[^xib]*'
    s.subspec 'Resources' do |resources|
        resources.resource_bundle = {'Images' => ['DDCashless/Assets/**/*.{xcassets,png,gif}'],'Jsons' => ['DDCashless/Assets/Jsons/**/*.{json,png}'],'Nibs' => ['DDCashless/Classes/**/*.{xib}']}
    end
    # s.resource_bundles = {
    #   'DDAuth' => ['DDAuth/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'DDCommons', '~> 0.1.0'
    s.dependency 'DDConstants', '~> 0.1.0'
    s.dependency 'DDStorage', '~> 0.1.0'
    s.dependency 'DDEncryption', '~> 0.1.0'
    s.dependency 'DDLocations', '~> 0.1.0'
    s.dependency 'DDFilters', '~> 0.1.0'
    s.dependency 'DDOutlets', '~> 0.1.0'
  end
