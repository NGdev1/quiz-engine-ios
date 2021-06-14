ENV['COCOAPODS_DISABLE_STATS'] = 'true'

platform :ios, '11.0'

use_frameworks!

def md_pods
  pod 'MDFoundation',
    :tag => 'v1.0.0',
    :git => 'https://github.com/NGdev1/MDFoundation.git'
end

def vendor
  pod 'Moya', '13.0.1'
  pod 'Kingfisher', '5.15.0'
  pod 'SnapKit', '5.0.1'
end

target 'QuizEngine' do
  md_pods
  vendor
  pod 'Storable', path: './Modules/Storable'
  pod 'Map', path: './Modules/Map'
end
