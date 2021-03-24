#
# Be sure to run `pod lib lint DDFamilyUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDFamilyUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDFamilyUI.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'https://github.com/dev46/DDFamilyUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dev46' => 'awaiss@theentertainerasia.com' }
  s.source           = { :git => 'https://github.com/dev46/DDFamilyUI.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '10.0'
  s.source_files = 'DDFamilyUI/Classes/**/*.[^xib]*'
  s.subspec 'Resources' do |resources|
       resources.resource_bundle = {'Images' => ['DDFamilyUI/Assets/**/*.{xcassets,png,gif,jpg,jpeg}'],'Jsons' => ['DDFamilyUI/Assets/Jsons/**/*.{json}'],'Nibs' => ['DDFamilyUI/Classes/**/*.{xib}']}
      
      
  end
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'DDUI', '~> 0.1.0'
  s.dependency 'DDFamily', '~> 0.1.0'
  s.dependency 'DDSocial', '~> 0.1.0'
  
end
