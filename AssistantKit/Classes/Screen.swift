//
//  DeviceSize.swift
//  Pods
//
//  Created by Anatoliy Voropay on 6/8/16.
//  Copyright © 2016 Anatoliy Voropay. All rights reserved.
//

import UIKit

/**
 Available screen sizes

 - Parameter Unknown:
 - Parameter Inches_3_5:    Representing screens for iPhone 4, 4S
 - Parameter Inches_4_0:    Representing screens for iPhone 5, 5S
 - Parameter Inches_4_7:    Screens for iPhone 6, 6S
 - Parameter Inches_5_5:    Screens for iPhone 6Plus
 - Parameter Inches_7_9:    Screens for iPad Mini
 - Parameter Inches_9_7:    Screens for iPad
 - Parameter Inches_12_9:   Screens for iPad Pro
 */
public enum Screen: CGFloat {
    case Unknown     = 0
    case Inches_3_5  = 3.5
    case Inches_4_0  = 4.0
    case Inches_4_7  = 4.7
    case Inches_5_5  = 5.5
    case Inches_7_9  = 7.9
    case Inches_9_7  = 9.7
    case Inches_12_9 = 12.9

    /// Return screen family
    public var family: ScreenFamily {
        switch self {
        case .Inches_3_5, Inches_4_0, Inches_4_7:
            return .Small

        case .Inches_5_5, Inches_7_9:
            return .Medium

        case .Inches_9_7, Inches_12_9:
            return .Big

        default:
            return .Unknown
        }
    }
}

/**
 These parameters are used to groups device screens into 3 groups:
 
 - Parameter Unknown:
 - Parameter Small:     Include devices with screen resolution 3.5, 4.0, 4.7 inches (iPhones without iPhone 6Plus)
 - Parameter Medium:    Include devices with screen resolution 5.5, 7.9 inches (iPhone 6Plus and iPad mini)
 - Parameter Big:       Include devices with biger screen resolutions (Regular iPad and iPad Pro)
 */
public enum ScreenFamily: String {
    case Unknown = "Unknown"
    case Small   = "Small"
    case Medium  = "Medium"
    case Big     = "Big"
}

/**
 Different types of screen scales

 - Parameter X1:
 - Parameter X2:
 - Parameter X3:
 - Parameter Unknown:
 */
public enum Scale: CGFloat, Comparable, Equatable {
    case X1      = 1.0
    case X2      = 2.0
    case X3      = 3.0
    case Unknown = 0
}

public func ==(lhs: Scale, rhs: Scale) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public func <(lhs: Scale, rhs: Scale) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

public func <=(lhs: Scale, rhs: Scale) -> Bool {
    return lhs.rawValue <= rhs.rawValue
}

public func >=(lhs: Scale, rhs: Scale) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}

public func >(lhs: Scale, rhs: Scale) -> Bool {
    return lhs.rawValue > rhs.rawValue
}

/**
 Detecting screen properties
 */
extension Device {

    /**
     Detect device screen.
     - Seealso: Screen
     */
    static public var screen: Screen {
        let size = UIScreen.mainScreen().bounds.size
        let height = max(size.width, size.height)

        switch height {
        case 480:
            return .Inches_3_5

        case 568:
            return .Inches_4_0

        case 667:
            return ( scale == .X3 ? .Inches_5_5 : .Inches_4_7 )

        case 736:
            return .Inches_5_5

        case 1024:
            switch version {
            case .PadMini, .PadMini2, .PadMini3, .PadMini4:
                return .Inches_7_9

            default:
                return .Inches_9_7
            }

        case 1366:
            return .Inches_12_9

        default:
            return .Unknown
        }
    }

    /**
     Detect screen resolution scale.
     - Seealso: Scale
     */
    static public var scale: Scale {
        let scale = UIScreen.mainScreen().scale

        switch scale {
        case 1.0:
            return .X1

        case 2.0:
            return .X2

        case 3.0:
            return .X3

        default:
            return .Unknown
        }
    }

    /// Return `true` for retina displays
    static public var isRetina: Bool {
        return scale > Scale.X1
    }
}

// MARK: Work with sizes

extension Device {

    /// Returns size for a specific device (iPad or iPhone/iPod)
    static public func size<T: AnyObject>(phone phone: T, pad: T) -> T {
        return ( Device.isPad ? pad : phone )
    }

    /**
     Return size depending on specific screen family.
     If Screen size is unknown (in this case ScreenFamily will be unknown too) it will return small value

     - Seealso: Screen, ScreenFamily
     */
    static public func size<T: AnyObject>(small small: T, medium: T, big: T) -> T {
        let family = Device.screen.family

        switch family {
        case .Small:
            return small

        case .Medium:
            return medium

        case .Big:
            return big

        default:
            return small
        }
    }

    /**
     Return value for specific screen size. Incoming parameter should be a screen size. If it is not defined 
     nearest value will be used. Code example:
     
     ```
     let sizes: [Screen:AnyObject] = [
         .Inches_3_5: 12,
         .Inches_4_0: 13,
         .Inches_4_7: 14,
         .Inches_9_7: 15
        ]
     let exactSize = Device.size(sizes: sizes) as! Int
     let _ = UIFont(name: "Arial", size: CGFloat(exactSize))
     ```
     
     After that your font will be:
     * 12 for 3.5" inches (older devices)
     * 13 for iPhone 5, 5S
     * 14 for iPhone 6, 6Plus and iPad mini
     * and 15 for other iPads

     - Seealso: Screen
    */
    static public func size<T: AnyObject>(sizes sizes: [Screen : T]) -> T? {
        let screen = Device.screen
        var nearestValue: T?
        var distance = CGFloat.max

        for (key, value) in sizes {
            // Prevent from iterating whole array
            if (key == screen) {
                return value
            }

            let actualDistance = fabs(key.rawValue - screen.rawValue)
            if actualDistance < distance {
                nearestValue = value
                distance = actualDistance
            }
        }

        return nearestValue
    }

}