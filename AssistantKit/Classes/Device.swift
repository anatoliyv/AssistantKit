//
//  Device.swift
//  Pods
//
//  Created by Anatoliy Voropay on 6/8/16.
//  Copyright © 2016 Anatoliy Voropay. All rights reserved.
//

import UIKit

/**
 Used to get information about current, device, screen or iOS version.
 
 **Device version information**
 
 To get current device type use:
 
 ```
 let device = Device.type
 
 switch device {
 case .Phone: print("iPhone")
 case .Pad: print("iPad")
 case .Pod: print("iPod")
 case .Simulator: print("Simulator")
 default: print("Unknown")
 }
 ```
 
 You can check exact device version with next code. All possible values of `version` could be
 found in Version enum, Version.swift file.
 
 ```
 let version = Device.version
 
 switch version {
 case .Phone5S: print("iPhone 5S")
 case .PadPro: print("iPad Pro")
 default: print("Other device")
 }
 ```
 
 There are few properties that detect global device type not depending is it simulator or not.
 
 ```
 Device.isPhone     // true for iPhones
 Device.isPad       // true for iPads
 Device.isPadPro    // true for iPadPros
 ```
 
 Simulator detecting is easy

 ```
 Device.isSimulator // true for Simulators
 ```
 
 **Device screen parameters**
 
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
 
 **Detecting screen family**
 
 Owten it's required to bing different parameters for specific screen resolution. 
 There are 2 methods that will help you to detect what parameter to use. But 
 wirst of all let me introduce ScreenFamily.
 
 This is enum that breaks all possible screen resolutions into 3 groups:
 - ScreenFamily.*Small*:        All iPhones/iPods without iPhone 6Plus
 - ScreenFamily.*Medium*:       iPhone 6Plus and iPad Mini
 - ScreenFamily.*Big*:          iPad and iPad Pro
 
 You can detect screen family by:
 
 ```
 let family = Device.screen.family
 ```
 
 And now back to methods. To assign different values for iPhone and iPad devices you can use this method:

 ```
 let size = Device.size(13, pad: 15)
 let font = UIFont(name: "Arial", size: CGFloat(size))
 ```
 
 On iPhones your font size will be 13.0, on iPads 15.0
 
 Another method based on ScreenFamily:
 
 ```
 let otherSize = Device.size(12, medium: 14, big: 15)
 let otherFont = UIFont(name: "Arial", size: CGFloat(otherSize))
 ```
 
 In this case for small screens your font will be 12.0, for medium 14.0 and for big 15.0 inches
 
 *Important notice:* By default if screen family can not be detected `size` method will 
 assign small value.

 **Screen scale**

 Detecting screen scale is easy too:
 
 ```
 let scale == Device.scale
 
 switch scale {
 case .X1: print("Not retina")
 case .X2: print("Good")
 case .X3: print("Your device rocks!")
 }
 ```
 
 Also there is a property to detect if it's retina display:
 
 ```
 Device.isRetina // true if device screen scale greater than 1.0
 ```
 
 **Interface orientation**
 
 There are two properties that will help you to know current orientation:
 
 ```
 Device.isLandscape // true if landscape
 Device.isPortrait  // true if portrait
 ```
 
 **Detecting iOS version**

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
 
 **Working with directories**
 
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

 */
public struct Device {
    // Implementations is grouped by extensions:
    //  - Device.swift
    //  - Screen.swift
    //  - Type.swift
    //  - OS.swift
}

/**
 Detecting device state
 */
extension Device {

    /// Return `true` for landscape interface orientation
    static public var isLandscape: Bool {
        return ( UIApplication.sharedApplication().statusBarOrientation == .LandscapeLeft
            || UIApplication.sharedApplication().statusBarOrientation == .LandscapeRight )
    }

    /// Return `true` for portrait interface orientation
    static public var isPortrait: Bool {
        return !Device.isLandscape
    }
}
