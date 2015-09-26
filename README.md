# UIColor-BetterEquality

[![Version](https://img.shields.io/cocoapods/v/UIColor-BetterEquality.svg?style=flat)](http://cocoapods.org/pods/UIColor-BetterEquality)
[![License](https://img.shields.io/cocoapods/l/UIColor-BetterEquality.svg?style=flat)](http://cocoapods.org/pods/UIColor-BetterEquality)
[![Platform](https://img.shields.io/cocoapods/p/UIColor-BetterEquality.svg?style=flat)](http://cocoapods.org/pods/UIColor-BetterEquality)

## Usage

Changes the behavior of isEqual on UIColor to better capture useful equality.

Performs a component-wise comparison of colors for equality.  This allows for the comparison of colors that are saved to disk (via NSKeyedArchiver for example) and loaded again.  The float serialization is imprecise so this bins them with the precision of 1/255 for each channel.
                       
## Installation

UIColor-BetterEquality is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UIColor-BetterEquality"
```

## Author

Daniel Blakemore, DanBlakemore@gmail.com

## License

UIColor-BetterEquality is available under the MIT license. See the LICENSE file for more info.
