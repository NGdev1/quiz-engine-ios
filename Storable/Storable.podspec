Pod::Spec.new do |s|
  s.name = "Storable"
  s.version = "1.0"
  s.summary = "Обертка для работы с Keychain, UserDefaults"

  s.platform = :ios, "11.0"
  s.swift_version = "5.0"
  s.static_framework = true
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC -l"c++"' }

  s.description = "Обертка для работы с Keychain, UserDefaults"
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

  s.subspec 'Source' do |ss|
    ss.source_files = ["Source/**/*"]
  end


  s.dependency "KeychainAccess", "4.2.2"
  s.dependency "SwiftyUserDefaults", "5.3.0"

     
end

