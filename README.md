# OpenWeatherKit 
[![Build Status](https://www.bitrise.io/app/c0f61c2208d69ebf/status.svg?token=_M8JG4myn3kxurAo6KyrQQ&branch=master)](https://www.bitrise.io/app/c0f61c2208d69ebf) 
[![Build Status](https://travis-ci.org/bourvill/OpenWeatherKit.svg?branch=master)](https://travis-ci.org/bourvill/OpenWeatherKit)
[![Version](https://img.shields.io/cocoapods/v/OpenWeatherKit.svg?style=flat)](http://cocoapods.org/pods/OpenWeatherKit)
[![License](https://img.shields.io/cocoapods/l/OpenWeatherKit.svg?style=flat)](http://cocoapods.org/pods/OpenWeatherKit)
[![Platform](https://img.shields.io/cocoapods/p/OpenWeatherKit.svg?style=flat)](http://cocoapods.org/pods/OpenWeatherKit)

OpenWeatherKit is a library written in Swift.

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 9.2+
- Swift 4.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.3.1+ is required to build OpenWeatherKit.

To integrate OpenWeatherKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'OpenWeatherKit'
```

Then, run the following command:

```bash
$ pod install
```


## Usage
### Method available
	[] Weather
		[X] Latitude Longitude
		[X] OpenWeatheMap City id
	[] ForeCast
		[X] Latitude Longitude
		[X] OpenWeatheMap City id


### Code Implementation
First:
```swift
import OpenWeatherKit
```

In your view controller's
```swift
let weatherApi = WeatherApi(key: "YOUR_OPEN_WEATHER_API_KEY")
weatherApi.getWeatherFor(lat: "5.567788", lon: "1.5544") { result in
	switch result {
        case .success(let weather):
            self.cityLabel.text = weather.name
            self.tempLabel.text = "\(weather.main.temp)"
        case .error(_):
            //Do something
            break
    }
}
```

## License

OpenWeatherKit is released under the MIT license.
