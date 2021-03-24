#
# Be sure to run `pod lib lint DDAccounts.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDAccounts'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDAccounts.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/etDev24/DDAccounts'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'etDev24' => 'et_dev24@TheEntertainerMe.com' }
  s.source           = { :git => 'https://github.com/etDev24/DDAccounts.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '10.0'

      s.source_files = 'DDAccounts/Classes/**/*.[^xib]*'
    s.subspec 'Resources' do |resources|
        resources.resource_bundle = {'Images' => ['DDAccounts/Assets/**/*.{xcassets,png,gif}'],'Jsons' => ['DDAccounts/Assets/Jsons/**/*.{json,png}'],'Nibs' => ['DDAccounts/Classes/**/*.{xib}']}
    end
    # s.resource_bundles = {
    #   'DDAuth' => ['DDAuth/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'DDCommons', '~> 0.1.0'
    s.dependency 'DDModels', '~> 0.1.0'
    s.dependency 'DDConstants', '~> 0.1.0'
    s.dependency 'DDAuth', '~> 0.1.0'
    s.dependency 'DDStorage', '~> 0.1.0'
    s.dependency 'DDFamily', '~> 0.1.0'
    s.dependency 'DDProducts', '~> 0.1.0'
    s.dependency 'DDUI', '~> 0.1.0'
    s.dependency 'DDPodGamification'
    s.dependency 'MRCircularProgressView'
    s.dependency 'Branch', '~> 0.30.0'
    s.dependency 'FBSDKCoreKit', '5.8.0'
    s.dependency 'FBSDKLoginKit', '5.8.0'
    s.dependency 'FBSDKShareKit', '5.8.0'

  end
