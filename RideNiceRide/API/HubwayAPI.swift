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
  case networkError
}

class HubwayAPI: NSObject {

  typealias StationDataCompletion = ([Station]?, Error?) -> ()

  // MARK: - Properties (public)
  let dataStack: DATAStack
  let stationName = "Station"

  required init(dataStack: DATAStack) {
    self.dataStack = dataStack
  }

  //swiftlint:disable function_body_length
  func getStations(completionHandlerForStations: @escaping StationDataCompletion) {
    Alamofire.request(K.HubwayAPI.hubwayURL).responseJSON { response in
      guard case let .failure(error) = response.result else {
        let data = response.result.value as? [String: Any]
        if let foo = data {
          guard let json = foo["stationBeanList"] as? [[String: Any]] else {
            log.error("ERROR: Very bad, very, very bad. No JSON in the data returned in the response from Hubway???")
            return
          }
          Sync.changes(json, inEntityNamed: self.stationName, dataStack: self.dataStack, completion: { (error) in
            let dataModelStations = self.fetch(forEntityName: "Station", in: self.dataStack.mainContext)
            guard let stations = dataModelStations as? [Station] else {
              return completionHandlerForStations(nil, HubwayAPIError.failedRequest)
            }
            completionHandlerForStations(stations, nil)
          })
        }
        return
      }

      if let error = error as? AFError {
        switch error {
        case .invalidURL(let url):
          print("Invalid URL: \(url) - \(error.localizedDescription)")
        case .parameterEncodingFailed(let reason):
          print("Parameter encoding failed: \(error.localizedDescription)")
          print("Failure Reason: \(reason)")
        case .multipartEncodingFailed(let reason):
          print("Multipart encoding failed: \(error.localizedDescription)")
          print("Failure Reason: \(reason)")
        case .responseValidationFailed(let reason):
          print("Response validation failed: \(error.localizedDescription)")
          print("Failure Reason: \(reason)")

          switch reason {
          case .dataFileNil, .dataFileReadFailed:
            print("Downloaded file could not be read")
          case .missingContentType(let acceptableContentTypes):
            print("Content Type Missing: \(acceptableContentTypes)")
          case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
          case .unacceptableStatusCode(let code):
            print("Response status code was unacceptable: \(code)")
          }
        case .responseSerializationFailed(let reason):
          print("Response serialization failed: \(error.localizedDescription)")
          print("Failure Reason: \(reason)")
        }
        print("Underlying error: \(error.underlyingError)")
        completionHandlerForStations(nil, error)
      } else if let error = error as? URLError {
        print("URLError occurred: \(error)")
        completionHandlerForStations(nil, error)
      } else {
        print("Unknown error: \(error)")
        completionHandlerForStations(nil, error)
      }
    }
  }

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
  //swiftlint:enable function_body_length

  func fetch(forEntityName entityName: String, withId id: String = "", in context: NSManagedObjectContext) -> [NSManagedObject] {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
    if !id.isEmpty {
      fetchRequest.predicate = NSPredicate(format: "id = %@", id)
    }
    do {
      let objects = try context.fetch(fetchRequest)
      return objects
    } catch let error as NSError {
      log.error(":: ERROR: \(error.localizedDescription)")
      fatalError("Unexpected error executing core data fetch request for entities. error: \(error.localizedDescription)")
    }
  }

  static func fetchCountFor(entityName: String, predicate: NSPredicate, in context: NSManagedObjectContext) -> Int {
    var count: Int = 0
    context.performAndWait {
      let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
      fetchRequest.predicate = predicate
      fetchRequest.resultType = NSFetchRequestResultType.countResultType

      do {
        count = try context.count(for: fetchRequest)
      } catch let error as NSError {
        log.error("Error returning number of objects for entity: \(entityName) in context \(context.name). Error description: \(error.localizedDescription)")
      }
    }
    return count
  }

  func removeFavorite(forStationId stationId: String, in context: NSManagedObjectContext) {
    let results = self.fetch(forEntityName: "FavoriteStation", withId: stationId, in: context)
    log.info("About to delete \(results.count) number of FavoriteStation's. ")

    for object in results {
      log.info("About to delete FavoriteStation: \((object as? FavoriteStation)?.stationName)")
      context.delete(object)
      log.info("Deleted FavoriteStation: \((object as? FavoriteStation)?.stationName)")
    }

    do {
      try context.save()
    } catch let error as NSError {
      log.error(":: ERROR: \(error.localizedDescription)")
      fatalError("Unexpected error delteing FavoriteStation for id: \(stationId). error: \(error.localizedDescription)")
    }
  }
}
