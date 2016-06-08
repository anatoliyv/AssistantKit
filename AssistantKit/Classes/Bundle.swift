//
//  Build.swift
//  Pods
//
//  Created by Anatoliy Voropay on 6/8/16.
//  Copyright © 2016 Anatoliy Voropay. All rights reserved.
//

import Foundation

/**
 Used for getting current build information.
 
 **Getting bundle version**
 
 Return bundle version string:
 
 ```
 Bundle.bundleVersion // "3.1.0" i.e.
 ```
 
 Return bundle short version string:
 
 ```
 Bundle.bundleShortVersion // "3.1" i.e
 ```
 
 Getting bundle identifier is easy too:
 
 ```
 Bundle.bundleIdentifier // com.apple.example i.e.
 ```
 
 **Default directories**
 
 As it's often required to get access to Document or Cache directories inside your bundle
 I've added few methods that makes it easy to work with it.
 
 Working with .DocumentDirectory:
 
 ```
 Bundle.documentsDirectoryURL                       // Return NSURL to .DocumentDirectory
 Bundle.documentsDirectoryPath                      // Return path string to .DocumentDirectory
 Bundle.filePathInDocumentsDirectory("test.data")   // Return path to file inside .DocumentDirectory
 ```
 
 Working with .CachesDirectory:

 ```
 Bundle.cachesDirectoryURL                          // Return NSURL to .CachesDirectory
 Bundle.cachesDirectoryPath                         // Return path string to .CachesDirectory
 Bundle.filePathInCachesDirectory("user.cache")     // Return path to file inside .CachesDirectory
 ```

 */
public struct Bundle {

}

// MARK: Getting build details information

extension Bundle {

    /// Return bundle version
    static public var bundleVersion: String {
        return NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    /// Return bundle short version
    static public var bundleShortVersion: String {
        return NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    /// Return bundle version
    static public var bundleIdentifier: String {
        return NSBundle.mainBundle().infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown"
    }
}

// MARK: Getting default app folders

extension Bundle {

    // MARK: .DocumentDirectory

    /// URL to bundle .DocumentDirectory
    static public var documentsDirectoryURL: NSURL {
        return documentsDirectoryURL(.DocumentDirectory)
    }

    /// Path to bundle .DocumentDirectory
    static public var documentsDirectoryPath: String {
        return documentsDirectoryPath(.DocumentDirectory)
    }

    /// Path to file in bundle .DocumentDirectory
    static public func filePathInDocumentsDirectory(toFile file: String) -> String {
        return filePathInDocumentsDirectory(.DocumentDirectory, toFile: file)
    }

    // MARK: .CachesDirectory

    /// URL to bundle .CachesDirectory
    static public var cachesDirectoryURL: NSURL {
        return documentsDirectoryURL(.CachesDirectory)
    }

    /// Path to bundle .CachesDirectory
    static public var cachesDirectoryPath: String {
        return documentsDirectoryPath(.CachesDirectory)
    }

    /// Path to file in bundle .CachesDirectory
    static public func filePathInCachesDirectory(toFile file: String) -> String {
        return filePathInDocumentsDirectory(.CachesDirectory, toFile: file)
    }

    // MARK: Helpers

    static private func documentsDirectoryURL(directory: NSSearchPathDirectory) -> NSURL {
        let URLs = NSFileManager.defaultManager().URLsForDirectory(directory, inDomains: .UserDomainMask)
        let URL = URLs[URLs.count - 1]
        return URL
    }

    /// Path to bundle .DocumentDirectory
    static private func documentsDirectoryPath(directory: NSSearchPathDirectory) -> String {
        let URLs = NSFileManager.defaultManager().URLsForDirectory(directory, inDomains: .UserDomainMask)
        let URL = URLs[URLs.count - 1]
        return URL.absoluteString
    }

    static public func filePathInDocumentsDirectory(directory: NSSearchPathDirectory, toFile file: String) -> String {
        let URLs = NSFileManager.defaultManager().URLsForDirectory(directory, inDomains: .UserDomainMask)
        let URL = URLs[URLs.count - 1]
        return (URL.absoluteString as NSString).stringByAppendingPathComponent(file)
    }
}
