platform :ios, '7.0'
inhibit_all_warnings!

target "JLshopios” do
pod 'AFNetworking', '~> 3.1.0'
pod 'SDWebImage' , '~> 3.7.3'
pod 'MJExtension', '~> 2.5.6'
pod 'MJRefresh', '~> 3.0.7'
pod 'MBProgressHUD', '~> 0.9.1'
pod 'IQKeyboardManager', '~> 3.3.6'
#pod 'ShareSDK3'
#pod 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
#pod 'ShareSDK3/ShareSDKPlatforms/QQ'
#pod 'ShareSDK3/ShareSDKPlatforms/WeChat'
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ARCHS'] = 'armv7 arm64'
        end
    end
end
