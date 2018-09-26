//
//  Build.swift
//  Pods
//
//  Created by Anatoliy Voropay on 6/8/16.
//  Copyright © 2016 Anatoliy Voropay. All rights reserved.
//

import Foundation

/// Used for getting current build information.
///
/// **Getting bundle version**
///
/// Return bundle version string:
///
/// ```
/// Bundle.bundleVersion // "3.1.0" i.e.
/// ```
///
/// Return bundle short version string:
///
/// ```
/// Bundle.bundleShortVersion // "3.1" i.e
/// ```
///
/// Getting bundle identifier is easy too:
///
/// ```
/// Bundle.bundleIdentifier // com.apple.example i.e.
/// ```
///
/// **Default directories**
///
/// It's often required to get access to Document or Cache directories inside your bundle
/// I've added few methods that makes it easy to work with it.
///
/// Working with .DocumentDirectory:
///
/// ```
/// Bundle.documentsDirectoryURL                       // Return NSURL to .DocumentDirectory
/// Bundle.documentsDirectoryPath                      // Return path string to .DocumentDirectory
/// Bundle.filePathInDocumentsDirectory("test.data")   // Return path to file inside .DocumentDirectory
/// ```
///
/// Working with .CachesDirectory:
///
/// ```
/// Bundle.cachesDirectoryURL                          // Return NSURL to .CachesDirectory
/// Bundle.cachesDirectoryPath                         // Return path string to .CachesDirectory
/// Bundle.filePathInCachesDirectory("user.cache")     // Return path to file inside .CachesDirectory
/// ```
///
/// **Working with directories**
///
/// There are few helper methods to make access to Documents and Caches directoies easier.
/// Take a look at code examples:
///
/// ```
/// Bundle.documentsDirectoryURL           // URL to .DocumentDirectory
/// Bundle.documentsDirectoryPath          // Path to .DocumentDirectory
/// Bundle.cachesDirectoryURL              // URL to .CachesDirectory
/// Bundle.cachesDirectoryPath             // Path to .CachesDirectory
///
/// let filePath = "directory/filename.txt"
///
/// Bundle.filePathInDocumentsDirectory(toFile: filePath)  // Path to file in .DocumentDirectory
/// Bundle.filePathInCachesDirectory(toFile: filePath)     // Path to file in .CachesDirectory
///
/// ```
public struct Bundle {

}

/// Getting build details information
extension Bundle {

    /// Return bundle version
    static public var bundleVersion: String {
        return Foundation.Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    /// Return bundle short version
    static public var bundleShortVersion: String {
        return Foundation.Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    /// Return bundle version
    static public var bundleIdentifier: String {
        return Foundation.Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown"
    }
}

/// Getting default app folders
extension Bundle {

    // MARK: .DocumentDirectory

    /// URL to bundle .DocumentDirectory
    static public var documentsDirectoryURL: URL {
        return documentsDirectoryURL(.documentDirectory)
    }

    /// Path to bundle .DocumentDirectory
    static public var documentsDirectoryPath: String {
        return documentsDirectoryPath(.documentDirectory)
    }

    /// Path to file in bundle .DocumentDirectory
    static public func filePathInDocumentsDirectory(toFile file: String) -> String {
        return filePathInDocumentsDirectory(.documentDirectory, toFile: file)
    }

    // MARK: .CachesDirectory

    /// URL to bundle .CachesDirectory
    static public var cachesDirectoryURL: URL {
        return documentsDirectoryURL(.cachesDirectory)
    }

    /// Path to bundle .CachesDirectory
    static public var cachesDirectoryPath: String {
        return documentsDirectoryPath(.cachesDirectory)
    }

    /// Path to file in bundle .CachesDirectory
    static public func filePathInCachesDirectory(toFile file: String) -> String {
        return filePathInDocumentsDirectory(.cachesDirectory, toFile: file)
    }

    // MARK: Helpers

    static fileprivate func documentsDirectoryURL(_ directory: FileManager.SearchPathDirectory) -> URL {
        let URLs = FileManager.default.urls(for: directory, in: .userDomainMask)
        let URL = URLs[URLs.count - 1]
        return URL
    }

    /// Path to bundle .DocumentDirectory
    static fileprivate func documentsDirectoryPath(_ directory: FileManager.SearchPathDirectory) -> String {
        let URLs = FileManager.default.urls(for: directory, in: .userDomainMask)
        let URL = URLs[URLs.count - 1]
        return URL.absoluteString
    }

    static public func filePathInDocumentsDirectory(_ directory: FileManager.SearchPathDirectory, toFile file: String) -> String {
        let URLs = FileManager.default.urls(for: directory, in: .userDomainMask)
        let URL = URLs[URLs.count - 1]
        return (URL.absoluteString as NSString).appendingPathComponent(file)
    }
}
