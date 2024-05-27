Pod::Spec.new do |s|
  s.name         = 'DebugRing'
  s.version      = '0.0.1'
  s.summary      = 'DebugRing'
  s.homepage     = 'https://github.com/BaldStudio/DebugRing.git'
  s.license      = { :type => 'MIT', :text => 'LICENSE' }
  s.author       = { 'crzorz' => 'crzorz@outlook.com' }
  s.source       = { :git => 'git@github.com:BaldStudio/DebugRing.git', :tag => s.version.to_s }

  s.platform = :ios, '13.0'
  s.swift_version = '5.0'
  s.static_framework = true

  s.source_files = 'DebugRing/Source/**/*'

  s.resource_bundles = {
      s.name => [
        'DebugRing/**/*.xib',
        'DebugRing/Assets/*'
      ]
  }

  s.ios.dependency 'BsFoundation'

  s.ios.dependency 'FLEX', '~> 5.22.10'
end
