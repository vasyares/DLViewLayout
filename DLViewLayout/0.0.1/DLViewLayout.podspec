Pod::Spec.new do |s|
  s.name         = "DLViewLayout"
  s.version      = "0.0.1"
  s.summary      = "Simple UIView category allowing view positioning & adjustments, command chaining and applying operations after view is added to superview."
  s.homepage     = "https://github.com/garnett/DLViewLayout"
  s.license      = 'MIT'
  s.author       = { "Denis Lebedev" => "d2.lebedev@gmail.com" }
  s.source       = { :git => "https://github.com/garnett/DLViewLayout.git", :tag => "0.0.1" }
  s.platform     = :ios, '4.3'
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.framework  = 'CoreGraphics'
  s.requires_arc = true
end
