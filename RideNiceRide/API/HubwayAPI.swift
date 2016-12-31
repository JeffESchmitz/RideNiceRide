//
//  HubwayAPI.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 12/31/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//
import UIKit
import DATAStack
import Sync
import Alamofire

class HubwayAPI: NSObject {
  let hubwayURL = "https://feeds.thehubway.com/stations/stations.json"
  let dataStack: DATAStack

  required init(dataStack: DATAStack) {
    self.dataStack = dataStack
  }

  func getStations(completion: @escaping (NSError?) -> Void) {
    Alamofire.request(hubwayURL).responseJSON { response in
      print(response.request!)  // original URL request
      print(response.response!) // HTTP URL response
      print(response.data!)     // server data
      print(response.result)   // result of response serialization

      if let JSON = response.result.value {
        print("JSON: \(JSON)")
      }

      //swiftlint:disable force_cast
      let data = response.result.value as! [String: Any]
      print("response.result.value: \(data)")
//      Sync.changes(data["stationBeanList"] as! [[String: AnyObject]], inEntityNamed: "Station", dataStack: self.dataStack, completion: { (error) in
//        completion(error)
//      })
      Sync.changes(data["stationBeanList"] as! [[String: Any]], inEntityNamed: "Station", dataStack: self.dataStack, completion: { (error) in
        completion(error)
      })
      //swiftlint:enable force_cast
    }
  }

}
//class HubwayAPI {
////  // Singleton code - TODO: bring back when DATASTack is working...
////  var testVariable = ""
////  class func sharedInstance() -> HubwayAPI {
////    //swiftlint:disable nesting
////    struct Singleton {
////      static var sharedInstance = HubwayAPI()
////    }
////    //swiftlint:enable nesting
////    return Singleton.sharedInstance
////  }
//}
