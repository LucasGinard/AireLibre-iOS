# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'airelibre' do
  use_frameworks!
  use_modular_headers!

  pod 'GoogleMaps', '>= 8.4.0'

  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  
  pod 'MaterialComponents/Buttons'

  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        end
      end
    end
  end
end
