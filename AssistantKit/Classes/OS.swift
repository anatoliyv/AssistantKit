//
//  Version.swift
//  Pods
//
//  Created by Anatoliy Voropay on 6/8/16.
//  Copyright © 2016 Anatoliy Voropay. All rights reserved.
//

import Foundation

/// Detecting iOS version
extension Device {

    /// Current iOS version as string
    public static var osVersion: OSVersion {
        return OSVersion(UIDevice.current.systemVersion)
    }

    public static var os8 = OSVersion("8")
    public static var os9 = OSVersion("9")
    public static var os10 = OSVersion("10")
    public static var os11 = OSVersion("11")

    /// Struct to work with OS version
    public struct OSVersion {

        fileprivate(set) var version: String

        public init(_ version: String) {
            let characters = CharacterSet(charactersIn: "01234567890.")
            let string = version.trimmingCharacters(in: characters.inverted)
            let clearedString = version.trimmingCharacters(in: characters)

            if clearedString.count > 0 {
                print("WARNING: Wrong delimiter used for AppVersion: \(version). Will remove it.")
            }

            self.version = string
        }

        fileprivate var versionNumbers: [String] {
            let characters = CharacterSet(charactersIn: ".")
            var components = version.components(separatedBy: characters)

            while true {
                if  let last = components.last,
                    last == "0"
                {
                    components.removeLast()
                    continue
                }

                break
            }

            return components
        }
    }
}

/// `Equatable` protocol implementation
extension Device.OSVersion: Equatable {

    public static func == (lhs: Device.OSVersion, rhs: Device.OSVersion) -> Bool {
        let lComponents = lhs.versionNumbers
        let rComponents = rhs.versionNumbers

        guard lComponents.count == rComponents.count else { return false }
        let maxIndex = lComponents.count

        for index in 0..<maxIndex {
            if  let lInt = Int(lComponents[index]),
                let rInt = Int(rComponents[index]),
                lInt != rInt
            {
                return false
            }
        }

        return true
    }

}

/// `Comparable` protocol implementation
extension Device.OSVersion: Comparable {

    public static func < (lhs: Device.OSVersion, rhs: Device.OSVersion) -> Bool {
        let lComponents = lhs.versionNumbers
        let rComponents = rhs.versionNumbers
        let maxIndex = max(lComponents.count, rComponents.count)

        for index in 0..<maxIndex {
            guard lComponents.count != index else { return true }
            guard rComponents.count != index else { return false }

            if  let lInt = Int(lComponents[index]),
                let rInt = Int(rComponents[index])
            {
                if lInt < rInt { return true }
                if lInt > rInt { return false }
            }
        }

        return false
    }
}
