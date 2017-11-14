![AssistantKit](https://cloud.githubusercontent.com/assets/1595032/15893439/631458ec-2d88-11e6-8566-4023999df805.png)

[![CI Status](http://img.shields.io/travis/anatoliyv/AssistantKit.svg?style=flat)](https://travis-ci.org/anatoliyv/AssistantKit)
[![Version](https://img.shields.io/cocoapods/v/AssistantKit.svg?style=flat)](http://cocoapods.org/pods/AssistantKit)
[![License](https://img.shields.io/cocoapods/l/AssistantKit.svg?style=flat)](http://cocoapods.org/pods/AssistantKit)
[![Platform](https://img.shields.io/cocoapods/p/AssistantKit.svg?style=flat)](http://cocoapods.org/pods/AssistantKit)
![](https://img.shields.io/badge/Supported-iOS8-4BC51D.svg?style=flat)
![](https://img.shields.io/badge/Swift3-compatible-4BC51D.svg?style=flat)


Easy way to detect device environment:
- [x] [Device model and version](https://github.com/anatoliyv/AssistantKit#device-version-information)
- [x] [Screen resolution](https://github.com/anatoliyv/AssistantKit#device-screen-parameters)
- [x] [Interface orientation](https://github.com/anatoliyv/AssistantKit#interface-orientation)
- [x] [iOS version](https://github.com/anatoliyv/AssistantKit#detecting-and-comparing-ios-version)
- [x] [Battery state](https://github.com/anatoliyv/AssistantKit#battery)
- [x] [Environment](https://github.com/anatoliyv/AssistantKit#environment)


Helps to:
- [x] [work with bundle Document and Cache folders](https://github.com/anatoliyv/AssistantKit/blob/master/README.md#working-with-directories)
- [x] [easily assign sizes for different devices](https://github.com/anatoliyv/AssistantKit#detecting-screen-family)

## Installation

AssistantKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AssistantKit"
```

## Usage

### Device version information

To get the current device type, use:

```swift
let device = Device.type

switch device {
case .phone:      print("iPhone")
case .pad:        print("iPad")
case .pod:        print("iPod")
case .simulator:  print("Simulator")
default:          print("Unknown")
}
```

You can check the exact device version with next code. All possible values of `version` can be
found in the `Version` enum, located in the `Version.swift` file.

```swift
let version = Device.version

switch version {
case .phone4:       print("iPhone 4")
case .phone4S:      print("iPhone 4S")
case .phone5:       print("iPhone 5")
case .phone5C:      print("iPhone 5C")
case .phone5S:      print("iPhone 5S")
case .phone6:       print("iPhone 6")
case .phone6S:      print("iPhone 6S")
case .phone6Plus:   print("iPhone 6 Plus")
case .phone6SPlus:  print("iPhone 6 S Plus")

case .pad1:         print("iPad 1")
case .pad2:         print("iPad 2")
case .pad3:         print("iPad 3")
case .pad4:         print("iPad 4")
case .padAir:       print("iPad Air")
case .padAir2:      print("iPad Air 2")
case .padMini:      print("iPad Mini")
case .padMini2:     print("iPad Mini 2")
case .padMini3:     print("iPad Mini 3")
case .padMini4:     print("iPad Mini 4")
case .padPro:       print("iPad Pro")

case .podTouch1:    print("iPod 1")
case .podTouch2:    print("iPod 2")
case .podTouch3:    print("iPod 3")
case .podTouch4:    print("iPod 4")
case .podTouch5:    print("iPod 5")
case .podTouch6:    print("iPod 6")

case .simulator:    print("Simulator")

default:            print("Unknown device")
}
```

There are few properties that detect device type

```swift
Device.isPhone     // true for iPhones even if it's Simulator
Device.isPhoneX    // true for iPhoneX even if it's Simulator
Device.isPad       // true for iPads even if it's Simulator
Device.isPadPro    // true for iPad Pros even if it's Simulator
Device.isPod       // true for iPods
Device.isSimulator // true for Simulators
```

To get raw device code use

```
Device.versionCode
```

### Device screen parameters

Detecting screen size can be detected with next code. All possible values could be
found in the `Screen` enum, located in `Screen.swift`.

```swift
let screen = Device.screen

switch screen {
case .inches_3_5:  print("3.5 inches")
case .inches_4_0:  print("4.0 inches")
case .inches_4_7:  print("4.7 inches")
case .inches_5_5:  print("5.5 inches")
case .inches_7_9:  print("7.9 inches")
case .inches_9_7:  print("9.7 inches")
case .inches_12_9: print("12.9 inches")
default:           print("Other display")
}
```

### Compare screens

`Screen` is cinfirming to `Comparable` protocol:

```
Screen.inches_3_5 < Screen.inches_4_0 // Will be `true`
```

### Detecting screen family

Often it is required to assign different parameters based on specific screen resolution.
There are 3 methods that will help you to detect what parameters to use. But
first of all let me introduce `ScreenFamily`.

This is enum that breaks all possible screens into 3 groups:
- `.old`:          Reproduce old iPhones with 3.5 and 4.0 inches screens
- `.small`:        Other iPhones/iPods without iPhone 6 Plus
- `.medium`:       iPhone 6 Plus and iPad Mini
- `.big`:          iPad and iPad Pro

You can detect screen family by:

```swift
let family = Device.screen.family
```

And now back to methods:

#### Value by device type

To assign different values for iPhone and iPad devices you can use:

```swift
// Method definition
static public func size<T: Any>(phone phone: T, pad: T) -> T

// Usage example
let size = Device.size(phone: 13, pad: 15)
let font = UIFont(name: "Arial", size: CGFloat(size))
```

On iPhones your font size will be 13.0, on iPads 15.0

#### Value by ScreenFamily

Another method based on `ScreenFamily`:

```swift
// Method definition
static public func size<T: Any>(small small: T, medium: T, big: T) -> T

// Usage example
let otherSize = Device.size(small: 12, medium: 14, big: 15)
let otherFont = UIFont(name: "Arial", size: CGFloat(otherSize))
```

In this case for small screens your font will be 12.0, for medium 14.0 and for big 15.0 inches.

*Important notice:* By default if screen family can not be detected `size` method will
assign small value.

#### Value by exact screen size

Also you can return value for specific screen size. There is another size method you can use.
Incoming parameter should be a screen size. If it is not defined nearest value will be used. Code example:

```swift
// Method definition
static public func size<T: Any>(sizes sizes: [Screen : T]) -> T?

// Usage example
let sizes: [Screen: AnyObject] = [
   .inches_3_5: 12,
   .inches_4_0: 13,
   .inches_4_7: 14,
   .inches_9_7: 15
  ]
let exactSize = Device.size(sizes: sizes) as! Int
let _ = UIFont(name: "Arial", size: CGFloat(exactSize))
```

*Important notice:* This method can return `nil` if you pass an empty array as a parameter. Be careful with implicit unwrapping.

After that your font will be:
- 12 for 3.5" inches (older devices)
- 13 for iPhone 5, 5S
- 14 for iPhone 6, 6Plus and iPad mini
- and 15 for other iPads

### Screen scale

```swift
let scale = Device.scale

switch scale {
case .x1: print("Not retina")
case .x2: print("Retina 2X")
case .x3: print("Retina 3X")
default:  print("Unknown scale")
}
```

Also there is a property to detect if it's retina display:

```swift
Device.isRetina // true if device screen scale > 1.0
```

### Interface orientation

There are two properties that will help you to know current orientation:

```swift
Device.isLandscape // true if landscape
Device.isPortrait  // true if portrait
```

## Detecting and comparing iOS version

You can detect iOS version in runtime. There are next different methods that will help you to
do it:

 ```swift
 Device.osVersion                               // Current version as a `OSVersion` model

 Device.osVersion == Device.os9                 // true if iOS 9.0
 Device.osVersion >= Device.os9                 // true if iOS >= 9.0
 Device.osVersion < Device.os11                 // true if iOS < 11.0
 etc.
 ```

There are next constants representating Main iOS versions:

 ```swift
 Device.os8
 Device.os9
 Device.os10
 Device.os11
 ```

### Working with directories

There are few helper methods to make access to Documents and Caches directoies easier.
Take a look at code examples:

```swift
Bundle.documentsDirectoryURL           // URL to .DocumentDirectory
Bundle.documentsDirectoryPath          // Path to .DocumentDirectory
Bundle.cachesDirectoryURL              // URL to .CachesDirectory
Bundle.cachesDirectoryPath             // Path to .CachesDirectory

let filePath = "directory/filename.txt"
Bundle.filePathInDocumentsDirectory(toFile: filePath)  // Path to file in .DocumentDirectory
Bundle.filePathInCachesDirectory(toFile: filePath)     // Path to file in .CachesDirectory
```

## Environment

Used to detect environment options. Right now there is only one property:

```
/// Return `true` if running unit tests
Environment.isRunningUnitTests
```

## Battery

There is a way to get battery state and level with these methods. It will enable monitoring if it's not enabled yet.

```
Device.Battery.state // Represent `UIDeviceBatteryState`
Device.Battery.level // in range 0...1 -1 for simulators
```

## TODO

- [ ] Add tvOS support

Write me or make a pull request if you have any ideas what else functionality can be useful in this repo.

## Author

- anatoliy.voropay@gmail.com
- [@anatoliy_v](https://twitter.com/anatoliy_v)
- [LinkedIn](https://www.linkedin.com/in/anatoliyvoropay)

## More Device-detecting libs
- [Ehkoo's Device](https://github.com/Ekhoo/Device)
- [Schickling's Device.swift](https://github.com/schickling/Device.swift)
- [DeviceKit](https://github.com/dennisweissmann/DeviceKit)

## License

AssistantKit is available under the MIT license. See the LICENSE file for more info.
