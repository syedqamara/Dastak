#
# Be sure to run `pod lib lint DDHome.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDHome'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDHome.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/zubair-ets/DDHome'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zubair-ets' => 'et_dev42@dynamicdelivery.com' }
  s.source           = { :git => 'https://github.com/zubair-ets/DDHome.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DDHome/Classes/**/*'
  s.subspec 'Resources' do |resources|
      resources.resource_bundle = {'Images' => ['DDHome/Assets/**/*.{xcassets,png,gif}'],'Jsons' => ['DDHome/Assets/Jsons/**/*.{json,png}'],'Nibs' => ['DDHome/**/*.{xib}']}
  
end

s.dependency 'DDCommons', '~> 0.1.0'
s.dependency 'DDConstants', '~> 0.1.0'
s.dependency 'DDUI', '~> 0.1.0'
s.dependency 'DDAuthUI', '~> 0.1.0'
s.dependency 'DDLocationsUI', '~> 0.1.0'

end
