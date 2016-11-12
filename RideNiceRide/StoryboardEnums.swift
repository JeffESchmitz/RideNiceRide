//
//  StoryboardEnums.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/12/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
//    return Self.storyboard().instantiateViewControllerWithIdentifier(self.rawValue)
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

struct StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    case MainViewControllerScene = "MainViewController"
    static func instantiateMainViewController() -> MainViewController {
      guard let vc = StoryboardScene.Main.MainViewControllerScene.viewController() as? MainViewController
        else {
          fatalError("ViewController 'MainViewController' is not of the expected class MainViewController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
