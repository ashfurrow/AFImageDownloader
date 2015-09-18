Pod::Spec.new do |s|
  s.name         = 'AFImageDownloader'
  s.version      = '1.1.0'
  s.summary      = 'Downloads JPEG images asynchronously and decompresses them on a background thread.'
  s.author       = { 'Ash Furrow' => 'ash@ashfurrow.com' }
  s.source       = { :git => 'https://github.com/ashfurrow/AFImageDownloader.git', :tag => '1.1.0' }
  s.source_files = 'Classes', '*.{h,m}'
  s.license	     = 'MIT'
  s.homepage     = 'https://github.com/AshFurrow/AFImageDownloader'
  s.platform     = :ios, '5.0'
  s.license      = 'MIT'
end
