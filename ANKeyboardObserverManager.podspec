Pod::Spec.new do |s|

  s.name         = 'ANKeyboardObserverManager'
  s.version      = '1.0.0'
  s.summary      = 'ANKeyboardObserverManager'
  s.homepage     = 'https://github.com/candyan/ANKeyboardObserverManager'
  s.license      = 'MIT'
  s.author       = { 'Candyan' => 'liuyanhp@gmail.com' }
  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source       = {
      :git => 'https://github.com/candyan/ANKeyboardObserverManager.git',
      :tag => s.version.to_s
  }

  s.source_files = 'Source/**/*.{c,h,m}'

end
