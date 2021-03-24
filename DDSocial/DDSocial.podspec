#
# Be sure to run `pod lib lint DDSocial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDSocial'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDSocial.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/awais.shahid/DDSocial'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'awais.shahid' => 'awaiss@theentertainerasia.com' }
  s.source           = { :git => 'https://github.com/awais.shahid/DDSocial.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DDSocial/Classes/**/*'
  
  s.dependency 'DDUI', '~> 0.1.0'
  s.dependency 'DDCommons', '~> 0.1.0'
  s.dependency 'DDConstants', '~> 0.1.0'
  s.dependency 'DDModels', '~> 0.1.0'
  
  s.dependency 'FBSDKCoreKit', '5.8.0'
  s.dependency 'FBSDKLoginKit', '5.8.0'
  s.dependency 'FBSDKShareKit', '5.8.0'

end
