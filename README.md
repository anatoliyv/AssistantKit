![AssistantKit](https://cloud.githubusercontent.com/assets/1595032/15893439/631458ec-2d88-11e6-8566-4023999df805.png)

[![CI Status](http://img.shields.io/travis/anatoliyv/AssistantKit.svg?style=flat)](https://travis-ci.org/anatoliyv/AssistantKit)
[![Version](https://img.shields.io/cocoapods/v/AssistantKit.svg?style=flat)](http://cocoapods.org/pods/AssistantKit)
[![License](https://img.shields.io/cocoapods/l/AssistantKit.svg?style=flat)](http://cocoapods.org/pods/AssistantKit)
[![Platform](https://img.shields.io/cocoapods/p/AssistantKit.svg?style=flat)](http://cocoapods.org/pods/AssistantKit)
![](https://img.shields.io/badge/Supported-iOS8-4BC51D.svg?style=flat-square)
![](https://img.shields.io/badge/Swift 2-compatible-4BC51D.svg?style=flat-square)


Easy way to detect device environment:
- [x] [Device model and version](https://github.com/anatoliyv/AssistantKit#device-version-information)
- [x] [Screen resolution](https://github.com/anatoliyv/AssistantKit#device-screen-parameters)
- [x] [Interface orientation](https://github.com/anatoliyv/AssistantKit#interface-orientation)
- [x] [iOS version](https://github.com/anatoliyv/AssistantKit#detecting-and-comparing-ios-version)

Helps to:
- [x] [work with bundle Document and Cache folders](https://github.com/anatoliyv/AssistantKit/blob/master/README.md#working-with-directories)
- [x] [easy way to assign sizes for different devices](https://github.com/anatoliyv/AssistantKit#detecting-screen-family)

## Installation

AssistantKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AssistantKit"
```

## Usage

### Device version information

To get current device type use:

```
let device = Device.type

switch device {
case .Phone:      print("iPhone")
case .Pad:        print("iPad")
case .Pod:        print("iPod")
case .Simulator:  print("Simulator")
default:          print("Unknown")
}
```

You can check exact device version with next code. All possible values of `version` could be
found in Version enum, Version.swift file.

```
let version = Device.version

switch version {
case .Phone4:       print("iPhone 4")
case .Phone4S:      print("iPhone 4S")
case .Phone5:       print("iPhone 5")
case .Phone5C:      print("iPhone 5C")
case .Phone5S:      print("iPhone 5S")
case .Phone6:       print("iPhone 6")
case .Phone6S:      print("iPhone 6S")
case .Phone6Plus:   print("iPhone 6 Plus")
case .Phone6SPlus:  print("iPhone 6 S Plus")

case .Pad1:         print("iPad 1")
case .Pad2:         print("iPad 2")
case .Pad3:         print("iPad 3")
case .Pad4:         print("iPad 4")
case .PadAir:       print("iPad Air")
case .PadAir2:      print("iPad Air 2")
case .PadMini:      print("iPad Mini")
case .PadMini2:     print("iPad Mini 2")
case .PadMini3:     print("iPad Mini 3")
case .PadMini4:     print("iPad Mini 4")
case .PadPro:       print("iPad Pro")

case .PodTouch1:    print("iPod 1")
case .PodTouch2:    print("iPod 2")
case .PodTouch3:    print("iPod 3")
case .PodTouch4:    print("iPod 4")
case .PodTouch5:    print("iPod 5")
case .PodTouch6:    print("iPod 6")

case .Simulator:    print("Simulator")

default:            print("Unknown device")
}
```

There are few properties that detect device type

```
Device.isPhone     // true for iPhones
Device.isPad       // true for iPads
Device.isPadPro    // true for iPadPros
Device.isPod       // true for Pods
Device.isSimulator // true for Simulators
```

### Device screen parameters

Detecting screen size can be detected with next code. All possible values could be
found in Screen enum, Screen.swift

```
let screen = Device.screen

switch screen {
case .Inches_3_5:  print("3.5 inches")
case .Inches_4_0:  print("4.0 inches")
case .Inches_4_7:  print("4.7 inches")
case .Inches_5_5:  print("5.5 inches")
case .Inches_7_9:  print("7.9 inches")
case .Inches_9_7:  print("9.7 inches")
case .Inches_12_9: print("12.9 inches")
default:           print("Other display")
}
```

### Detecting screen family

Often it is required to assign different parameters based on specific screen resolution.
There are 2 methods that will help you to detect what parameters to use. But
first of all let me introduce ScreenFamily.

This is enum that breaks all possible screens into 3 groups:
- ScreenFamily.Small:        All iPhones/iPods without iPhone 6Plus
- ScreenFamily.Medium:       iPhone 6Plus and iPad Mini
- ScreenFamily.Big:          iPad and iPad Pro

You can detect screen family by:

```
let family = Device.screen.family
```

And now back to methods:

#### Value by device type

To assign different values for iPhone and iPad devices you can use:

```
// Method definition
static public func size<T: AnyObject>(phone phone: T, pad: T) -> T

// Usage example
let size = Device.size(13, pad: 15)
let font = UIFont(name: "Arial", size: CGFloat(size))
```

On iPhones your font size will be 13.0, on iPads 15.0

#### Value by ScreenFamily

Another method based on ScreenFamily:

```
// Method definition
static public func size<T: AnyObject>(small small: T, medium: T, big: T) -> T

// Usage example
let otherSize = Device.size(12, medium: 14, big: 15)
let otherFont = UIFont(name: "Arial", size: CGFloat(otherSize))
```

In this case for small screens your font will be 12.0, for medium 14.0 and for big 15.0 inches

*Important notice:* By default if screen family can not be detected `size` method will
assign small value.

#### Value by exact screen size

Also you can return value for specific screen size. There is another size method you can use.
Incoming parameter should be a screen size. If it is not defined nearest value will be used. Code example:

```
// Method definition
static public func size<T: AnyObject>(sizes sizes: [Screen : T]) -> T?

// Usage example
let sizes: [Screen:AnyObject] = [
   .Inches_3_5: 12,
   .Inches_4_0: 13,
   .Inches_4_7: 14,
   .Inches_9_7: 15
  ]
let exactSize = Device.size(sizes: sizes) as! Int
let _ = UIFont(name: "Arial", size: CGFloat(exactSize))
```

*Important notice:* This method can return nil if you pass empty array as a parameter. Be careful with implicit unwrapping.

After that your font will be:
- 12 for 3.5" inches (older devices)
- 13 for iPhone 5, 5S
- 14 for iPhone 6, 6Plus and iPad mini
- and 15 for other iPads

### Screen scale

```
let scale = Device.scale

switch scale {
case .X1: print("Not retina")
case .X2: print("Retina 2X")
case .X3: print("Retina 3X")
default:  print("Unknown scale")
}
```

Also there is a property to detect if it's retina display:

```
Device.isRetina // true if device screen scale greater than 1.0
```

### Interface orientation

There are two properties that will help you to know current orientation:

```
Device.isLandscape // true if landscape
Device.isPortrait  // true if portrait
```

## Detecting and comparing iOS version

You can detect iOS version in runtime. There are 5 different methods that will help you to
detect it:

```
Device.osVersionString                         // Current version as a String i.e. "9.3"
Device.osVersion                               // Current version as a Float i.e. 9.3

Device.osVersionEqualTo("9.0")                 // true if iOS 9.0
Device.osVersionGreaterThan("9.0")             // true if iOS > 9.0
Device.osVersionGreaterThanOrEqualTo("9.0")    // true if iOS >= 9.0
Device.osVersionLessThan("9.0")                // true if iOS < 9.0
Device.osVersionLessThanOrEqualTo("9.0")       // true if iOS <= 9.0
```

### Working with directories

There are few helper methods to make access to Documents and Caches directoies easier.
Take a look at code examples:

```
Bundle.documentsDirectoryURL           // URL to .DocumentDirectory
Bundle.documentsDirectoryPath          // Path to .DocumentDirectory
Bundle.cachesDirectoryURL              // URL to .CachesDirectory
Bundle.cachesDirectoryPath             // Path to .CachesDirectory

let filePath = "directory/filename.txt"
Bundle.filePathInDocumentsDirectory(toFile: filePath)  // Path to file in .DocumentDirectory
Bundle.filePathInCachesDirectory(toFile: filePath)     // Path to file in .CachesDirectory

```

## TODO

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
