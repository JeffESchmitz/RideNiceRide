//
//  FavoritesViewController.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/12/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import Willow
import Cent
import CoreData
import DATAStack
import MapKit

class FavoritesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var emptyTableMessage: UILabel!
  lazy var hubwayAPI: HubwayAPI = HubwayAPI(dataStack: self.dataStack)
  unowned var dataStack: DATAStack
  var tableData: [FavoriteStation] = []


  required init?(coder aDecoder: NSCoder) {
    //swiftlint:disable force_cast
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    self.dataStack = appdelegate.dataStack
    //swiftlint:enable force_cast
    super.init(coder: aDecoder)
  }

  // MARK: - View Lifecycle functions
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "Favorites"
    self.emptyTableMessage.text = "You don't have any Favorites yet.\n\nYou can add one by tapping on a pin and then 'Add Favorite'."
    self.emptyTableMessage.sizeToFit()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNavigationBarItem()

    let mainContext = dataStack.mainContext

    let objects = self.fetch(forEntityName: String(describing: FavoriteStation.self), in: mainContext)
    log.info("objects.count: \(objects.count)")
    self.tableData.removeAll()
    if let stations = objects as? [FavoriteStation] {
      self.tableData = stations
    }

    self.tableView.reloadData()
  }


  // MARK: - Helper/utility functions
  //swiftlint:disable force_cast
  //swiftlint:disable force_try
  func fetch(forEntityName entityName: String, in context: NSManagedObjectContext) -> [NSManagedObject] {
    let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
    let objects = try! context.fetch(request)
    return objects
  }

  func clearOutFavoriteData(in context: NSManagedObjectContext) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: FavoriteStation.self))
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    do {
      try context.execute(deleteRequest)
    } catch let error as NSError {
      print(":: ERROR: \(error.localizedDescription)")
    }
  }
  //swiftlint:enable force_cast
  //swiftlint:enable force_try
}
extension FavoritesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tableData.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    if tableData.isNotEmpty {
      emptyTableMessage.isHidden = true
      return 1
    } else {
      emptyTableMessage.isHidden = false
      return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //swiftlint:disable force_cast
    let cell = self.tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier) as! FavoritesTableViewCell
    // swiftlint:enable force_cast
    cell.favoriteStation = self.tableData[indexPath.row]
    return cell
  }
}

extension FavoritesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let stationToRemove = self.tableData[indexPath.row]

      if let stationId = stationToRemove.id {
        hubwayAPI.removeFavorite(forStationId: stationId, in: dataStack.mainContext)
      }

      guard let favoriteStations = hubwayAPI.fetch(forEntityName: "FavoriteStation", in: dataStack.mainContext) as? [FavoriteStation] else {
        log.error("Error occured while fetching FavoriteStations after deleting a row.")
        return
      }
      self.tableData = favoriteStations

      // delete the row from the UITableView
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // For v1 of app, just open iOS Maps application with selected favorite.
    // For v2, send these coordinates back to the mapView, and center and select the pin tapped.
    let selectedFavoriteStation = self.tableData[indexPath.row]
    print("Favorite lat: \(selectedFavoriteStation.latitude), long: \(selectedFavoriteStation.longitude)")
    print("")
    openMapForFavorite(favoriteStation: selectedFavoriteStation)
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let deselectedCell = tableView.cellForRow(at: indexPath)!
    deselectedCell.backgroundColor = UIColor.clear
  }

  func openMapForFavorite(favoriteStation: FavoriteStation) {
    let latitude: CLLocationDegrees = Double(favoriteStation.latitude!)!
    let longitude: CLLocationDegrees = Double(favoriteStation.longitude!)!

    let regionDistance: CLLocationDistance = 10000
    let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
    let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
    let options = [
      MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
      MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = favoriteStation.stationName
    mapItem.openInMaps(launchOptions: options)
  }
}
