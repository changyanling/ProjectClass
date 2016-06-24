Pod::Spec.new do |s|
s.name     = 'ProjectClass'
s.version  = '1.0.1'
s.license  = 'MIT'
s.summary  = 'A delightful iOS and OS X networking framework.'
s.homepage = 'https://github.com/changyanling/ProjectClass.git'
s.authors  = { 'haha' }
s.source   = { :git => 'https://github.com/changyanling/ProjectClass.git', :tag => s.version, :submodules => true }
s.requires_arc = true

s.public_header_files = 'ProjectClass/SplashViewController.h'
s.source_files = 'ProjectClass/SplashViewController.{h,m}'

end

