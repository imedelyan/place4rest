platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
#  pod 'Moya', '~> 12.0'
#  pod 'PromiseKit', '~> 6.5'
  pod 'Swinject', '~> 2.5'
  pod 'SwinjectStoryboard', '~> 2.1'
#  pod 'KeychainSwift', '~> 13.0'
  pod 'R.swift', '~> 5.0.2'
  pod 'Mapbox-iOS-SDK', '~> 4.8'
end

def test_pods
#  pod 'Quick', '~> 1.3.2'
#  pod 'Nimble', '~> 7.3.1'
#  pod 'Mockingjay'
#  pod 'Sourcery', '~> 0.15.0'
end

target 'place4rest' do
  shared_pods
end

target 'place4restTests' do
  shared_pods
  test_pods
end
