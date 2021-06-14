Pod::Spec.new do |s|
  s.name = "Map"
  s.version = "1.0"
  s.summary = "Map"

  s.platform = :ios, "11.0"
  s.swift_version = "5.0"
  s.static_framework = true
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC -l"c++"' }

  s.description = "Обертка для работы с картой"
  s.license = {
    :type => "Custom",
    :text => <<-LICENSE,
      Copyright 2021
      Permission is granted to MD
    LICENSE
  }

  s.author = "Andreichev Michael"
  s.homepage = "https://github.com/NGDev1/iosPods"
  s.source = {:git => "https://github.com/NGDev1/iosPods", :tag => "1.0.0"}
  s.resource_bundle = { 'MapResources' => ['Resources/**/*', 'Source/**/*.{xib}'] }

  s.subspec 'Source' do |ss|
    ss.source_files = ["Source/**/*"]
  end

  s.dependency 'YandexMapsMobile', '4.0.0-lite'
end
