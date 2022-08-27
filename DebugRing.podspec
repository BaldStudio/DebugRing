Pod::Spec.new do |s|

  s.name         = 'DebugRing'
  s.version      = '0.0.1'
  s.summary      = 'DebugRing'
  s.homepage     = 'http://github.com/DebugRing.git'
  s.license      = { :type => 'MIT', :text => 'LICENSE' }
  s.author       = { 'crzorz' => 'crzorz@outlook.com' }
  s.source       = { :git => 'http://github.com/DebugRing.git', :tag => s.version.to_s }

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
  
  s.dependency 'BsFoundation'
  s.dependency 'BsUIKit'
  s.dependency 'FLEX'
  
end
