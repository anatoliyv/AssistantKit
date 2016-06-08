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
        return Float(UIDevice.currentDevice().systemVersion)!
    }

    /// Current iOS version as string
    static public var osVersionString: String {
        return UIDevice.currentDevice().systemVersion
    }

    /// Detect iOS version is equal to
    static public func osVersionEqualTo(version: String) -> Bool {
        return compareVersionEqual(version, result: NSComparisonResult.OrderedSame)
    }

    /// Detect iOS version is greater than
    static public func osVersionGreaterThan(version: String) -> Bool {
        return compareVersionEqual(version, result: NSComparisonResult.OrderedDescending)
    }

    /// Detect iOS version is greater than or equal to
    static public func osVersionGreaterThanOrEqualTo(version: String) -> Bool {
        return compareVersionNotEqual(version, result: NSComparisonResult.OrderedAscending)
    }

    /// Detect iOS version is less than
    static public func osVersionLessThan(version: String) -> Bool {
        return compareVersionEqual(version, result: NSComparisonResult.OrderedAscending)
    }

    /// Detect iOS version is less than or equal
    static public func osVersionLessThanOrEqualTo(version: String) -> Bool {
        return compareVersionNotEqual(version, result: NSComparisonResult.OrderedAscending)
    }

    // MARK: Helpers

    static private func compareVersionEqual(version: String, result: NSComparisonResult) -> Bool {
        let currentVersion = UIDevice.currentDevice().systemVersion
        return currentVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == result
    }

    static private func compareVersionNotEqual(version: String, result: NSComparisonResult) -> Bool {
        let currentVersion = UIDevice.currentDevice().systemVersion
        return currentVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != result
    }
}
