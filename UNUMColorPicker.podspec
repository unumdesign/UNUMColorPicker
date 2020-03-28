#
# Be sure to run `pod lib lint UNUMColorPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UNUMColorPicker'
  s.version          = '1.1.1'
  s.summary          = 'UNUM color picker library.'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/unumdesign/UNUMColorPicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaoli1211' => 'zhaoli841211@gmail.com' }
  s.source           = { :git => 'https://github.com/unumdesign/UNUMColorPicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = 'UNUMColorPicker/Classes/**/*'
  
  s.resource_bundles = {
    'UNUMColorPicker' => ['UNUMColorPicker/Classes/**/*.{xib}']
  }
  s.frameworks = 'UIKit'

end
