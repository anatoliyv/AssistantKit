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
    case phone
    case pad
    case pod
    case simulator
    case unknown
}

/**
 Exact device version
 */
public enum Version: String {
    case phone4
    case phone4S
    case phone5
    case phone5C
    case phone5S
    case phone6
    case phone6Plus
    case phone6S
    case phone6SPlus
    case phoneSE
    case phone7
    case phone7Plus

    case pad1
    case pad2
    case padMini
    case pad3
    case pad4
    case padAir
    case padMini2
    case padAir2
    case padMini3
    case padMini4
    case padPro

    case podTouch1
    case podTouch2
    case podTouch3
    case podTouch4
    case podTouch5
    case podTouch6

    case simulator

    case unknown
}

/**
 Used to determinate device type
 */
extension Device {

    static fileprivate func versionCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        if let
            info = NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue),
            let code = String(validatingUTF8: info.utf8String!)
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
             "iPhone7,2", "iPhone7,1",
             "iPhone8,1", "iPhone8,2", "iPhone8,4",
             "iPhone9,1", "iPhone9,2", "iPhone9,3", "iPhone9,4":
            return .phone

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
            return .pad

        case "iPod1,1",
             "iPod2,1",
             "iPod3,1",
             "iPod4,1",
             "iPod5,1",
             "iPod7,1":
            return .pod

        case "i386", "x86_64":
            return .simulator

        default:
            return .unknown
        }
    }

    /// Return `true` for iPad-s
    static public var isPad: Bool {
        return ( UIDevice.current.userInterfaceIdiom == .pad )
    }

    /// Return `true` for iPahone-s
    static public var isPhone: Bool {
        return !isPad
    }

    /// Return `true` for iPadPro
    static public var isPadPro: Bool {
        return isPad && screen == .inches_12_9
    }

    /// Return `true` for Simulator
    static public var isSimulator: Bool {
        return type == .simulator
    }

    // MARK: Version

    static public var version: Version {
        let versionCode = Device.versionCode()

        switch versionCode {
        // Phones
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return .phone4

        case "iPhone4,1", "iPhone4,2", "iPhone4,3":
            return .phone4S

        case "iPhone5,1", "iPhone5,2":
            return .phone5

        case "iPhone5,3", "iPhone5,4":
            return .phone5C

        case "iPhone6,1", "iPhone6,2":
            return .phone5S

        case "iPhone7,2":
            return .phone6

        case "iPhone7,1":
            return .phone6Plus

        case "iPhone8,1":
            return .phone6S

        case "iPhone8,2":
            return .phone6SPlus

        case "iPhone8,4":
            return .phoneSE

        case "iPhone9,1", "iPhone9,3":
            return .phone7

        case "iPhone9,2", "iPhone9,4":
            return .phone7Plus


        // Pads
        case "iPad1,1":
            return .pad1

        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return .pad2

        case "iPad3,1", "iPad3,2", "iPad3,3":
            return .pad3

        case "iPad3,4", "iPad3,5", "iPad3,6":
            return .pad4

        case "iPad4,1", "iPad4,2", "iPad4,3":
            return .padAir

        case "iPad5,3", "iPad5,4":
            return .padAir2

        case "iPad2,5", "iPad2,6", "iPad2,7":
            return .padMini

        case "iPad4,4", "iPad4,5", "iPad4,6":
            return .padMini2

        case "iPad4,7", "iPad4,8", "iPad4,9":
            return .padMini3

        case "iPad5,1", "iPad5,2":
            return .padMini4

        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":
            return .padPro

        // Pods
        case "iPod1,1":
            return .podTouch1

        case "iPod2,1":
            return .podTouch2

        case "iPod3,1":
            return .podTouch3

        case "iPod4,1":
            return .podTouch4

        case "iPod5,1":
            return .podTouch5

        case "iPod7,1":
            return .podTouch6

        // Simulator
        case "i386", "x86_64":
            return .simulator

        // Unknown
        default:
            return .unknown
        }
    }
}
