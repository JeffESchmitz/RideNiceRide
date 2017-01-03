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

enum HubwayAPIError: Error {
  case unknown
  
  case failedRequest
  case invalidResponse
  case syncChangeError
}

class HubwayAPI: NSObject {
  
  typealias StationDataCompletion = ([Station]?, Error?) -> ()

  let hubwayURL = "https://feeds.thehubway.com/stations/stations.json"
  let dataStack: DATAStack
  let stationName = "Station"
  
  required init(dataStack: DATAStack) {
    self.dataStack = dataStack
  }
  
  func getStations(completionHandlerForStations: @escaping StationDataCompletion) {
    Alamofire.request(hubwayURL).responseJSON { response in
      //      print(response.request!)  // original URL request
      //      print(response.response!) // HTTP URL response
      //      print(response.data!)     // server data
      //      print(response.result)   // result of response serialization
      //
      //      if let JSON = response.result.value {
      //        print("JSON: \(JSON)")
      //      }
      
      //swiftlint:disable force_cast
      
      if let error = response.result.error {
        print("AlamoFire Error: \(error)")
        completionHandlerForStations(nil, error)
        
      } else if let data = response.result.value as? [String: Any] {
        print("response.result.value: \(data)")
        Sync.changes(data["stationBeanList"] as! [[String: Any]], inEntityNamed: self.stationName, dataStack: self.dataStack, completion: { (error) in
          completionHandlerForStations(nil, HubwayAPIError.syncChangeError)
        })
        
        let dataModelStations = self.fetch(forEntityName: self.stationName, in: self.dataStack.mainContext)
        
        if let stations = dataModelStations as? [Station] {
          print("stations.count: \(stations.count)")
          completionHandlerForStations(stations, nil)
        }
      } else {
        completionHandlerForStations(nil, HubwayAPIError.unknown)
      }
      //swiftlint:enable force_cast
    }
  }

  func fetch(forEntityName entityName: String, in context: NSManagedObjectContext) -> [NSManagedObject] {
    let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
    //    let objects = try! context.fetch(request)
    //    return objects
    do {
      let objects = try context.fetch(request)
      return objects
    } catch let error as NSError {
      log.error(":: ERROR: \(error.localizedDescription)")
      fatalError("Unexpected error executing core data fetch request for Station entity. error: \(error.localizedDescription)")
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
