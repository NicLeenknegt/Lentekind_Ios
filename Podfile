# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Lentekind_app' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Lentekind_app
  pod 'Alamofire', '~> 4.7.0'
  pod 'AlamofireObjectMapper', '~> 5.0'
  pod 'CodableFirebase'
  pod 'RealmSwift'
  pod 'FSCalendar'
  pod 'SwiftKeychainWrapper'

  target 'Lentekind_appTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Lentekind_appUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
