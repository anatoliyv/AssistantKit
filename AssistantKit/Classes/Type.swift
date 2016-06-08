//
//  Type.swift
//  Pods
//
//  Created by Anatoliy Voropay on 6/8/16.
//  Copyright © 2016 Anatoliy Voropay. All rights reserved.
//

import Foundation

/**
 - Parameter Phone:
 - Parameter Pad:
 - Parameter Pod:
 - Parameter Simulator:
 - Parameter Unknown
 */
public enum Type: String {
    case Phone
    case Pad
    case Pod
    case Simulator
    case Unknown
}

/**
 Exact device version
 */
public enum Version: String {
    case Phone4
    case Phone4S
    case Phone5
    case Phone5C
    case Phone5S
    case Phone6
    case Phone6Plus
    case Phone6S
    case Phone6SPlus
    case PhoneSE

    case Pad1
    case Pad2
    case PadMini
    case Pad3
    case Pad4
    case PadAir
    case PadMini2
    case PadAir2
    case PadMini3
    case PadMini4
    case PadPro

    case PodTouch1
    case PodTouch2
    case PodTouch3
    case PodTouch4
    case PodTouch5
    case PodTouch6

    case Simulator

    case Unknown
}

/**
 Used to determinate device type
 */
extension Device {

    static private func versionCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        if let
            info = NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: NSASCIIStringEncoding),
            code = String(UTF8String: info.UTF8String)
        {
            return code
        }

        return ""
    }

    /**
     Return device type
     - Seealso: Type
    */
    static public var type: Type {
        let versionCode = Device.versionCode()

        switch versionCode {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3",
             "iPhone4,1", "iPhone4,2", "iPhone4,3",
             "iPhone5,1", "iPhone5,2",
             "iPhone5,3", "iPhone5,4",
             "iPhone6,1", "iPhone6,2",
             "iPhone7,2",
             "iPhone7,1",
             "iPhone8,1",
             "iPhone8,2",
             "iPhone8,4":
            return .Phone

        case "iPad1,1",
             "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4",
             "iPad3,1", "iPad3,2", "iPad3,3",
             "iPad3,4", "iPad3,5", "iPad3,6",
             "iPad4,1", "iPad4,2", "iPad4,3",
             "iPad5,3", "iPad5,4",
             "iPad2,5", "iPad2,6", "iPad2,7",
             "iPad4,4", "iPad4,5", "iPad4,6",
             "iPad4,7", "iPad4,8", "iPad4,9",
             "iPad5,1", "iPad5,2",
             "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":
            return .Pad

        case "iPod1,1",
             "iPod2,1",
             "iPod3,1",
             "iPod4,1",
             "iPod5,1",
             "iPod7,1":
            return .Pod

        case "i386", "x86_64":
            return .Simulator

        default:
            return .Unknown
        }
    }

    /// Return `true` for iPad-s
    static public var isPad: Bool {
        return ( UIDevice.currentDevice().userInterfaceIdiom == .Pad )
    }

    /// Return `true` for iPahone-s
    static public var isPhone: Bool {
        return !isPad
    }

    /// Return `true` for iPadPro
    static public var isPadPro: Bool {
        return isPad && screen == .Inches_12_9
    }

    /// Return `true` for Simulator
    static public var isSimulator: Bool {
        return type == .Simulator
    }

    // MARK: Version

    static public var version: Version {
        let versionCode = Device.versionCode()

        switch versionCode {
        // Phones
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return .Phone4

        case "iPhone4,1", "iPhone4,2", "iPhone4,3":
            return .Phone4S

        case "iPhone5,1", "iPhone5,2":
            return .Phone5

        case "iPhone5,3", "iPhone5,4":
            return .Phone5C

        case "iPhone6,1", "iPhone6,2":
            return .Phone5S

        case "iPhone7,2":
            return .Phone6

        case "iPhone7,1":
            return .Phone6Plus

        case "iPhone8,1":
            return .Phone6S

        case "iPhone8,2":
            return .Phone6SPlus

        case "iPhone8,4":
            return .PhoneSE

        // Pads
        case "iPad1,1":
            return .Pad1

        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return .Pad2

        case "iPad3,1", "iPad3,2", "iPad3,3":
            return .Pad3

        case "iPad3,4", "iPad3,5", "iPad3,6":
            return .Pad4

        case "iPad4,1", "iPad4,2", "iPad4,3":
            return .PadAir

        case "iPad5,3", "iPad5,4":
            return .PadAir2

        case "iPad2,5", "iPad2,6", "iPad2,7":
            return .PadMini

        case "iPad4,4", "iPad4,5", "iPad4,6":
            return .PadMini2

        case "iPad4,7", "iPad4,8", "iPad4,9":
            return .PadMini3

        case "iPad5,1", "iPad5,2":
            return .PadMini4

        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":
            return .PadPro

        // Pods
        case "iPod1,1":
            return .PodTouch1

        case "iPod2,1":
            return .PodTouch2

        case "iPod3,1":
            return .PodTouch3

        case "iPod4,1":
            return .PodTouch4

        case "iPod5,1":
            return .PodTouch5

        case "iPod7,1":
            return .PodTouch6

        // Simulator
        case "i386", "x86_64":
            return .Simulator

        // Unknown
        default:
            return .Unknown
        }
    }
}
