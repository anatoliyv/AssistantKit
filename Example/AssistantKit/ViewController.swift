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

    @IBAction func pressedTest(sender: AnyObject?) {
        testBundleFiles()
        testBundleVersions()
        testDeviceScreen()
        testDeviceType()
        testDeviceOS()
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
        print("Documents URL:   " + String(Bundle.documentsDirectoryURL))
        print("Documents path:  " + String(Bundle.documentsDirectoryPath))
        print("Caches URL:      " + String(Bundle.cachesDirectoryURL))
        print("Caches path:     " + String(Bundle.cachesDirectoryPath))
        print()

        print("Paths for file:  " + file)
        print("Documents:       " + Bundle.filePathInDocumentsDirectory(toFile: file))
        print("Caches:          " + Bundle.filePathInCachesDirectory(toFile: file))
        print()

        print("Paths for file:  " + fileWithPath)
        print("Documents:       " + Bundle.filePathInDocumentsDirectory(toFile: fileWithPath))
        print("Caches:          " + Bundle.filePathInCachesDirectory(toFile: fileWithPath))
        print()
    }

    func testBundleVersions() {
        print("*** Bundle versions")
        print("Version:         " + Bundle.bundleVersion)
        print("Short version:   " + Bundle.bundleShortVersion)
        print("Identifier:      " + Bundle.bundleIdentifier)
        print()
    }

    func testDeviceScreen() {
        print("*** Screen")
        print("screen:          " + String(Device.screen.rawValue))
        print("scale:           " + String(Device.scale.rawValue))
        print("isRetina:        " + String(Device.isRetina))
        print("isPortrait:      " + String(Device.isPortrait))
        print("isLandscape:     " + String(Device.isLandscape))
        print()

        print("family:          " + String(Device.screen.family.rawValue))
        print("size for device: " + String(Device.size(phone: "phone size", pad: "pad size")))
        print("size for family: " + String(Device.size(small: "small family", medium: "medium family", big: "big family")))

        let sizes: [Screen:AnyObject] = [
            .Inches_3_5: 12,
            .Inches_4_0: 13,
            .Inches_5_5: 14,
            .Inches_9_7: 15
        ]
        let exactSize = Device.size(sizes: sizes) as! Int
        print("exact size:      " + String(exactSize))
        print()
    }

    func testDeviceType() {
        print("*** Device Type")
        print("type:            " + String(Device.type.rawValue))
        print("version:         " + String(Device.version.rawValue))
        print("isPhone:         " + String(Device.isPhone))
        print("isPad:           " + String(Device.isPad))
        print("isPadPro:        " + String(Device.isPadPro))
        print("isSimulator:     " + String(Device.isSimulator))
        print()
    }

    func testDeviceOS() {
        let version = Device.osVersionString

        print("*** iOS")
        print("OS               " + String(Device.osVersion))
        print("OS String        " + String(Device.osVersionString))
        print("> 9.0            " + String(Device.osVersionGreaterThan("9.0")))
        print("< 9.0            " + String(Device.osVersionLessThan("9.0")))
        print("==               " + String(Device.osVersionEqualTo(version)))
        print(">= 9.0           " + String(Device.osVersionEqualTo("9.0")))
        print("<= 9.0           " + String(Device.osVersionEqualTo("9.0")))
        print()
    }

    func testCodeExamples() {
        let version = Device.version

        switch version {
        case .Phone4:       print("iPhone 4")
        case .Phone4S:      print("iPhone 4S")
        case .Phone5:       print("iPhone 5")
        case .Phone5C:      print("iPhone 5C")
        case .Phone5S:      print("iPhone 5S")
        case .Phone6:       print("iPhone 6")
        case .Phone6S:      print("iPhone 6S")
        case .Phone6Plus:   print("iPhone 6 Plus")
        case .Phone6SPlus:  print("iPhone 6 S Plus")

        case .Pad1:         print("iPad 1")
        case .Pad2:         print("iPad 2")
        case .Pad3:         print("iPad 3")
        case .Pad4:         print("iPad 4")
        case .PadAir:       print("iPad Air")
        case .PadAir2:      print("iPad Air 2")
        case .PadMini:      print("iPad Mini")
        case .PadMini2:     print("iPad Mini 2")
        case .PadMini3:     print("iPad Mini 3")
        case .PadMini4:     print("iPad Mini 4")
        case .PadPro:       print("iPad Pro")

        case .PodTouch1:    print("iPod 1")
        case .PodTouch2:    print("iPod 2")
        case .PodTouch3:    print("iPod 3")
        case .PodTouch4:    print("iPod 4")
        case .PodTouch5:    print("iPod 5")
        case .PodTouch6:    print("iPod 6")
            
        case .Simulator:    print("Simulator")
            
        default:            print("Unknown device")
        }
        
        let screen = Device.screen
        switch screen {
        case .Inches_3_5:  print("3.5 inches")
        case .Inches_4_0:  print("4.0 inches")
        case .Inches_4_7:  print("4.7 inches")
        case .Inches_5_5:  print("5.5 inches")
        case .Inches_7_9:  print("7.9 inches")
        case .Inches_9_7:  print("9.7 inches")
        case .Inches_12_9: print("12.9 inches")
        default:           print("Other display")
        }

        let scale = Device.scale
        switch scale {
        case .X1: print("Not retina")
        case .X2: print("Retina 2X")
        case .X3: print("Retina 3X")
        default:  print("Unknown scale")
        }

        let size = Device.size(phone: 13, pad: 15)
        let _ = UIFont(name: "Arial", size: CGFloat(size))

        let otherSize = Device.size(small: 12, medium: 14, big: 15)
        let _ = UIFont(name: "Arial", size: CGFloat(otherSize))

        let sizes: [Screen:AnyObject] = [
            .Inches_3_5: 12,
            .Inches_4_0: 13,
            .Inches_5_5: 14,
            .Inches_9_7: 15
        ]
        let exactSize = Device.size(sizes: sizes) as! Int
        let _ = UIFont(name: "Arial", size: CGFloat(exactSize))
    }
}

