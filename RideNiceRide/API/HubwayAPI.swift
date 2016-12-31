//
//  HubwayAPI.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 12/31/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

import Foundation

class HubwayAPI {
  var testVariable = ""

  class func sharedInstance() -> HubwayAPI {
    //swiftlint:disable nesting
    struct Singleton {
      static var sharedInstance = HubwayAPI()
    }
    //swiftlint:enable nesting
    return Singleton.sharedInstance
  }
}
