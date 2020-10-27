//
//  ViewController.swift
//  AssistantKit
//
//  Created by Anatoliy Voropay on 06/08/2016.
//  Copyright (c) 2016 Anatoliy Voropay. All rights reserved.
//

import UIKit
import AssistantKit

class ViewController: UIViewController {

    @IBAction open func pressedTest(sender: AnyObject?) {
        testBundleFiles()
        testBundleVersions()
        testDeviceScreen()
        testDeviceType()
        testDeviceOS()
        testEnvironment()
        testBattery()
        testCodeExamples()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Test logs

    func testBundleFiles() {
        let file = "file.data"
        let fileWithPath = "somefolder/other_file.data"

        print("*** Global paths")
        print("Documents URL:           " + String(describing: Bundle.documentsDirectoryURL))
        print("Documents path:          " + String(describing: Bundle.documentsDirectoryPath))
        print("Caches URL:              " + String(describing: Bundle.cachesDirectoryURL))
        print("Caches path:             " + String(describing: Bundle.cachesDirectoryPath))
        print()

        print("Paths for file:          " + file)
        print("Documents:               " + Bundle.filePathInDocumentsDirectory(toFile: file))
        print("Caches:                  " + Bundle.filePathInCachesDirectory(toFile: file))
        print()

        print("Paths for file:          " + fileWithPath)
        print("Documents:               " + Bundle.filePathInDocumentsDirectory(toFile: fileWithPath))
        print("Caches:                  " + Bundle.filePathInCachesDirectory(toFile: fileWithPath))
        print()
    }

    func testBundleVersions() {
        print("*** Bundle versions")
        print("Version:                 " + Bundle.bundleVersion)
        print("Short version:           " + Bundle.bundleShortVersion)
        print("Identifier:              " + Bundle.bundleIdentifier)
        print()
    }

    func testDeviceScreen() {
        print("*** Screen")
        print("screen:                  " + String(describing: Device.screen.rawValue))
        print("scale:                   " + String(describing: Device.scale.rawValue))
        print("isRetina:                " + String(Device.isRetina))
        print("isPortrait:              " + String(Device.isPortrait))
        print("isLandscape:             " + String(Device.isLandscape))
        print("isSlideOver:             " + String(Device.isSlideOverLayout))
        print()

        print("4.7 == 4.7:              " + String(describing: Screen.inches_4_7 == Screen.inches_4_7))
        print("4.0 < 4.7:               " + String(describing: Screen.inches_4_0 < Screen.inches_4_7))
        print("4.0 > 4.7:               " + String(describing: Screen.inches_4_0 > Screen.inches_4_7))
        print("4.0 >= 4.7:              " + String(describing: Screen.inches_4_0 > Screen.inches_4_7))
        print()
        
        print("4.7 < iPhone6:           " + String(describing: Screen.inches_4_7 < Version.phone6))
        print("4.7 <= iPhone6:          " + String(describing: Screen.inches_4_7 <= Version.phone6))
        print("4.7 > iPhone6:           " + String(describing: Screen.inches_4_7 > Version.phone6))
        print("4.7 >= iPhone6:          " + String(describing: Screen.inches_4_7 >= Version.phone6))
        print("4.7 == iPhone6:          " + String(describing: Screen.inches_4_7 == Version.phone6))
        print("4.7 == iPhone6 Plus:     " + String(describing: Screen.inches_4_7 == Version.phone6Plus))
        print()

        print("family:                  " + String(Device.screen.family.rawValue))
        print("size for device:         " + String(Device.size(phone: "phone size", pad: "pad size")))
        print("size for family:         " + String(Device.size(small: "small family", medium: "medium family", big: "big family")))

        let sizes: [Screen:Double] = [
            .inches_3_5: 3.5,
            .inches_4_0: 4.0,
            .inches_5_5: 5.5,
            .inches_5_8: 5.8,
            .inches_9_7: 9.7,
        ]
        let exactSize = Device.size(sizes: sizes)
        print("exact size:              " + String(describing: exactSize))
        print()
    }

    func testDeviceType() {
        print("*** Device Type")
        print("type:                    " + String(Device.type.rawValue))
        print("version:                 " + String(Device.version.rawValue))
        print("version code:            " + String(Device.versionCode))
        print("screen:                  " + String(describing: Device.screen))
        print("isPhone:                 " + String(Device.isPhone))
        print("isNotched:               " + String(Device.isNotched))
        print("isPad:                   " + String(Device.isPad))
        print("isPadPro:                " + String(Device.isPadPro))
        print("isSimulator:             " + String(Device.isSimulator))
        print()
    }

    func testDeviceOS() {
        print("*** iOS")
        print("OS String                " + String(describing: Device.osVersion))
        print("> 13.0                   " + String(describing: Device.osVersion > Device.os13))
        print("< 13.0                   " + String(describing: Device.osVersion < Device.os13))
        print("== 14.0                  " + String(describing: Device.osVersion == Device.os14))
        print("== 14.1                  " + String(describing: Device.osVersion == Device.OSVersion("14.1")))
        print(">= 11.0                  " + String(describing: Device.osVersion >= Device.os11))
        print("<= 11.0                  " + String(describing: Device.osVersion <= Device.os11))
        print()

        let testVersion = Device.OSVersion("10.3.2")
        print("Test version             " + String(describing: testVersion))
        print("<= 10.3.2                " + String(describing: testVersion <= Device.OSVersion("10.3.2")))
        print(">= 10.3.2                " + String(describing: testVersion >= Device.OSVersion("10.3.2")))
        print("== 10.3.2                " + String(describing: testVersion == Device.OSVersion("10.3.2")))
        print("< 10.3.2                 " + String(describing: testVersion < Device.OSVersion("10.3.2")))
        print("> 10.3.2                 " + String(describing: testVersion > Device.OSVersion("10.3.2")))
        print()
    }
    
    func testBattery() {
        print("*** Battery")
        print("State:                   " + String(describing: Device.Battery.state.rawValue))
        print("Level:                   " + String(describing: Device.Battery.level))
        print()
    }
    
    func testEnvironment() {
        print("*** Environment")
        print("isRunningUnitTests:      " + String(describing: Environment.isRunningUnitTests))
        print()
    }

    func testCodeExamples() {
        let version = Device.version

        switch version {
        case .phone4:       print("iPhone 4")
        case .phone4S:      print("iPhone 4S")
        case .phone5:       print("iPhone 5")
        case .phone5C:      print("iPhone 5C")
        case .phone5S:      print("iPhone 5S")
        case .phone6:       print("iPhone 6")
        case .phone6S:      print("iPhone 6S")
        case .phone6Plus:   print("iPhone 6 Plus")
        case .phone6SPlus:  print("iPhone 6 S Plus")
        case .phoneSE:      print("iPhone SE")
        case .phoneSE2:     print("iPhone SE 2")
        case .phone7:       print("iPhone 7")
        case .phone7Plus:   print("iPhone 7 Plus")
        case .phone8:       print("iPhone 8")
        case .phone8Plus:   print("iPhone 8 Plus")
        case .phoneX:       print("iPhone X")
        case .phoneXS:      print("iPhone XS")
        case .phoneXSMax:   print("iPhone XS Max")
        case .phoneXR:      print("iPhone X")
        case .phone11:      print("iPhone 11")
        case .phone11Pro:   print("iPhone 11 Pro")
        case .phone11ProMax:    print("iPhone 11 Pro Max")

        case .pad1:         print("iPad 1")
        case .pad2:         print("iPad 2")
        case .pad3:         print("iPad 3")
        case .pad4:         print("iPad 4")
        case .pad5:         print("iPad 5")
        case .pad6:         print("iPad 6")
        case .pad7:         print("iPad 7")

        case .padAir:       print("iPad Air")
        case .padAir2:      print("iPad Air 2")
        case .padAir3:      print("iPad Air 3")

        case .padMini:      print("iPad Mini")
        case .padMini2:     print("iPad Mini 2")
        case .padMini3:     print("iPad Mini 3")
        case .padMini4:     print("iPad Mini 4")
        case .padMini5:     print("iPad Mini 5")

        case .padPro9_7:    print("iPad Pro 9.7")
        case .padPro10_5:   print("iPad Pro 10.5")
        case .padPro11:     print("iPad Pro 11")
        case .padPro11_2th: print("iPad Pro 11 2th")
        case .padPro12_9:   print("iPad Pro 12 9\"")
        case .padPro12_9_2th:   print("iPad Pro 12 9\" 2th")
        case .padPro12_9_3th:   print("iPad Pro 12 9\" 3th")
        case .padPro12_9_4th:   print("iPad Pro 12 9\" 4th")


        case .podTouch1:    print("iPod 1")
        case .podTouch2:    print("iPod 2")
        case .podTouch3:    print("iPod 3")
        case .podTouch4:    print("iPod 4")
        case .podTouch5:    print("iPod 5")
        case .podTouch6:    print("iPod 6")
        case .podTouch7:    print("iPod 7")
            
        case .simulator:    print("Simulator")
            
        case .unknown:      print("Unknown device")
        }
        
        let screen = Device.screen
        switch screen {
        case .inches_3_5:   print("3.5 inches")
        case .inches_4_0:   print("4.0 inches")
        case .inches_4_7:   print("4.7 inches")
        case .inches_5_4:   print("5.4 inches")
        case .inches_5_5:   print("5.5 inches")
        case .inches_5_8:   print("5.8 inches")
        case .inches_6_1:   print("6.1 inches")
        case .inches_6_5:   print("6.5 inches")
        case .inches_6_7:   print("6.7 inches")
        case .inches_7_9:   print("7.9 inches")
        case .inches_9_7:   print("9.7 inches")
        case .inches_10_2:  print("10.2 inches")
        case .inches_10_5:  print("10.5 inches")
        case .inches_10_9:  print("10.9 inches")
        case .inches_11:    print("11 inches")
        case .inches_12_9:  print("12.9 inches")
        case .unknown:      print("Other display")
        }

        let scale = Device.scale
        switch scale {
        case .x1:       print("Not retina")
        case .x2:       print("Retina 2X")
        case .x3:       print("Retina 3X")
        case .unknown:  print("Unknown scale")
        }

        let size = Device.size(phone: 13, pad: 15)
        let _ = UIFont(name: "Arial", size: CGFloat(size))

        let otherSize = Device.size(small: 12, medium: 14, big: 15)
        let _ = UIFont(name: "Arial", size: CGFloat(otherSize))

        let sizes: [Screen:Any] = [
            .inches_3_5: 12,
            .inches_4_0: 13,
            .inches_5_5: 14,
            .inches_9_7: 15
        ]
        let exactSize = Device.size(sizes: sizes) as! Int
        let _ = UIFont(name: "Arial", size: CGFloat(exactSize))
        print()
    }
}

