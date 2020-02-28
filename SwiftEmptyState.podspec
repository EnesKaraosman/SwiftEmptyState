#
# Be sure to run `pod lib lint SwiftEmptyState.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftEmptyState'
  s.version          = '0.1.6'
  s.summary          = 'Display empty state in iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'You all faced success/error state, but how you behave in empty states?'

  s.homepage         = 'https://github.com/eneskaraosman/SwiftEmptyState'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'eneskaraosman' => 'eneskaraosman53@gmail.com' }
  s.source           = { :git => 'https://github.com/eneskaraosman/SwiftEmptyState.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'
  s.swift_version = '5'
  s.source_files = 'Sources/**/*.swift'
  
  # s.resource_bundles = {
  #   'SwiftEmptyState' => ['SwiftEmptyState/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
