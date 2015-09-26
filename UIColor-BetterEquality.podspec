Pod::Spec.new do |s|
  s.name             = "UIColor-BetterEquality"
  s.version          = "0.1.4"
  s.summary          = "Changes the behavior of isEqual on UIColor to better capture useful equality."
  s.description      = <<-DESC
                       Performs a component-wise comparison of colors for equality.

                       This allows for the comparison of colors that are saved to disk (via NSKeyedArchiver for example) and loaded again.  The float serialization is imprecise so this bins them with the precision of 1/255 for each channel.
                       DESC
  s.homepage         = "https://github.com/pixio/UIColor-BetterEquality"
  s.license          = 'MIT'
  s.author           = { "Daniel Blakemore" => "DanBlakemore@gmail.com" }
  s.source = {
    :git => "https://github.com/pixio/UIColor-BetterEquality.git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = '*.{h,m}'

  s.public_header_files = '*.h'
  s.frameworks = 'UIKit'
end
