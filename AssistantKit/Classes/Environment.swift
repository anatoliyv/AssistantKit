//
//  Environment.swift
//  Pods
//
//  Created by Anatoliy Voropay on 9/20/17.
//
//

import Foundation

/// `Environment` struct used to detect environment properties.
public struct Environment {

    /// Return `true` for running tests
    static public var isRunningUnitTests: Bool {
        return NSClassFromString("XCTest") != nil
    }
}
