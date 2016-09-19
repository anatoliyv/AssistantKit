//
//  Version.swift
//  Pods
//
//  Created by Anatoliy Voropay on 6/8/16.
//  Copyright © 2016 Anatoliy Voropay. All rights reserved.
//

import Foundation

/**
 Detecting iOS version
 */
extension Device {

    /// Current iOS version in as float
    static public var osVersion: Float {
        return Float(UIDevice.current.systemVersion)!
    }

    /// Current iOS version as string
    static public var osVersionString: String {
        return UIDevice.current.systemVersion
    }

    /// Detect iOS version is equal to
    static public func osVersionEqualTo(_ version: String) -> Bool {
        return compareVersionEqual(version, result: ComparisonResult.orderedSame)
    }

    /// Detect iOS version is greater than
    static public func osVersionGreaterThan(_ version: String) -> Bool {
        return compareVersionEqual(version, result: ComparisonResult.orderedDescending)
    }

    /// Detect iOS version is greater than or equal to
    static public func osVersionGreaterThanOrEqualTo(_ version: String) -> Bool {
        return compareVersionNotEqual(version, result: ComparisonResult.orderedAscending)
    }

    /// Detect iOS version is less than
    static public func osVersionLessThan(_ version: String) -> Bool {
        return compareVersionEqual(version, result: ComparisonResult.orderedAscending)
    }

    /// Detect iOS version is less than or equal
    static public func osVersionLessThanOrEqualTo(_ version: String) -> Bool {
        return compareVersionNotEqual(version, result: ComparisonResult.orderedAscending)
    }

    // MARK: Helpers

    static fileprivate func compareVersionEqual(_ version: String, result: ComparisonResult) -> Bool {
        let currentVersion = UIDevice.current.systemVersion
        return currentVersion.compare(version, options: NSString.CompareOptions.numeric) == result
    }

    static fileprivate func compareVersionNotEqual(_ version: String, result: ComparisonResult) -> Bool {
        let currentVersion = UIDevice.current.systemVersion
        return currentVersion.compare(version, options: NSString.CompareOptions.numeric) != result
    }
}
