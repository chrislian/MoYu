# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'MoYu' do
#objective-c
#pod 'SVProgressHUD',    '~> 2.0'
pod 'YYText',           '~> 1.0.7'
pod 'REFrostedViewController', '~> 2.0'
pod 'MJRefresh',    '~> 3.0'
pod 'BaiduMapKit',   '~> 2.0'

#swift
pod 'Alamofire',    '~> 4.0'
pod 'SwiftDate',    '~> 4.0'
pod 'SwiftyJSON'
pod 'SnapKit',      '~> 3.0'
pod 'Kingfisher',   '~> 3.0'
pod 'Spring', '~> 1.0'
pod 'AsyncSwift', '~> 2.0.0'
pod 'CryptoSwift', '~> 0.6.0'
pod 'Proposer', '~> 1.0.0'
pod 'RealmSwift'

end

target 'MoYuTests' do

end

target 'MoYuUITests' do

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
        end
    end
end
