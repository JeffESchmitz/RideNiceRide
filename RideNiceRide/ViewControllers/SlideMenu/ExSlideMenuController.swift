//
//  ExSlideMenuController.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/12/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//
import UIKit
import SlideMenuControllerSwift
import Willow

class ExSlideMenuController: SlideMenuController {

  override func isTagetViewController() -> Bool {
    if let vc = UIApplication.topViewController() {
      if vc is MainViewController
//        || vc is RentalHistoryViewController
      {
        return true
      }
    }
    return false
  }

  override func track(_ trackAction: SlideMenuController.TrackAction) {
    switch trackAction {
    case .leftTapOpen:
      log.event("TrackAction: left tap open.")
    case .leftTapClose:
      log.event("TrackAction: left tap close.")
    case .leftFlickOpen:
      log.event("TrackAction: left flick open.")
    case .leftFlickClose:
      log.event("TrackAction: left flick close.")
    case .rightTapOpen:
      log.event("TrackAction: right tap open.")
    case .rightTapClose:
      log.event("TrackAction: right tap close.")
    case .rightFlickOpen:
      log.event("TrackAction: right flick open.")
    case .rightFlickClose:
      log.event("TrackAction: right flick close.")
    }
  }
}
