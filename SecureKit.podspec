#
# Be sure to run `pod lib lint SecureKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SecureKit'
  s.version          = '1.0.1'
  s.summary          = 'A kit that secure the user sensitive data.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'It secures the user sensitive data using AES encryption given iv, key and pkcs7 parameters. It prevents reverse engineering stuffs.'

  s.homepage         = 'https://github.com/TolgaTaner/SecureKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TolgaTaner' => 'dev.tolgataner@icloud.com' }
  s.source           = { :git => 'https://github.com/TolgaTaner/SecureKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/TolgaTanerdev'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = 'SecureKit/Classes/**/*'

  # s.resource_bundles = {
  #   'SecureKit' => ['SecureKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'XCTest'
   s.dependency 'CryptoSwift'
   s.dependency 'KeychainSwift'
end
