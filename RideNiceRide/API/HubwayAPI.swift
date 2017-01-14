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
    do {
      let objects = try context.fetch(request)
      return objects
    } catch let error as NSError {
      log.error(":: ERROR: \(error.localizedDescription)")
      fatalError("Unexpected error executing core data fetch request for entity. error: \(error.localizedDescription)")
    }
  }
  
  //swiftlint:disable function_body_length
  func insertFavorite(forStation station: Station) -> NSManagedObject? {
    
    guard let stationName = station.stationName,
      let address1 = station.stAddress1,
      let address2 = station.stAddress2,
      let altitude = station.altitude,
      let availableBikes = station.availableBikes,
      let availableDocks = station.availableDocks,
      let city = station.city,
      let id = station.id,
      let landMark = station.landMark,
      let lastCommunicationTime = station.lastCommunicationTime,
      let latitude = station.latitude,
      let location = station.location,
      let longitude = station.longitude,
      let postalCode = station.postalCode,
      let statusKey = station.statusKey,
      let statusValue = station.statusValue,
      let totalDocks = station.totalDocks
      else {
      log.error(":: ERROR unwrapping station entity")
      return nil
    }
    
    self.dataStack.performInNewBackgroundContext { (backgroundContext) in
      
      _ = FavoriteStation(stationName: stationName, address1: address1, address2: address2, altitude: altitude, availableBikes: availableBikes, availableDocks: availableDocks, city: city, id: id, landMark: landMark, lastCommunicationTime: lastCommunicationTime, latitude: latitude, location: location, longitude: longitude, postalCode: postalCode, statusKey: statusKey, statusValue: statusValue, testStation: station.testStation, totalDocks: totalDocks, context: backgroundContext)
      
      do {
        try backgroundContext.save()
      } catch let error as NSError {
        log.error(":: ERROR: \(error.localizedDescription)")
        fatalError("Unexpected error inserting favorite Station. error: \(error.localizedDescription)")
      }
    }
    
    let favoriteFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteStation")
    favoriteFetchRequest.predicate = NSPredicate(format: "id = %@", id)
    
    do {
      let favoriteStation = try dataStack.mainContext.fetch(favoriteFetchRequest).first()
      return favoriteStation
    } catch let error as NSError {
      log.error(":: ERROR: \(error.localizedDescription)")
      fatalError("Unexpected error returning FavoriteStation for id: \(id). error: \(error.localizedDescription)")
    }
  }
  //swiftlint:disable function_body_length

  
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
