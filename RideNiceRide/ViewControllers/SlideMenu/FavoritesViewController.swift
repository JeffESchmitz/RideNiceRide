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

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!

  var tableData: [FavoriteStation] = [
    //    Station(name: "Huntington Ave", address: "Brigham Cir", bikes: "6", racks: "15"),
    //    Station(name: "Mt Pleasant St", address: "Broadway St", bikes: "11", racks: "15"),
    //    Station(name: "Mt Auburn", address: "Mt Auburn", bikes: "14", racks: "19")
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    generateStubTableDataOnBackgroundContext()
    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNavigationBarItem()
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tableData.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    // swiftlint:disable force_cast
    let cell = self.tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier) as! FavoritesTableViewCell
    // swiftlint:enable force_cast
    cell.favoriteStation = self.tableData[indexPath.row]
    return cell
  }

  //swiftlint:disable force_cast
  //swiftlint:disable force_try
  func generateStubTableDataOnBackgroundContext() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.dataStack.performInNewBackgroundContext { (backgroundContext) in
      self.clearOutFavoriteData(in: backgroundContext)

      _ = FavoriteStation(name: "Huntington Ave", address: "Brigham Cir", bikes: "6", docks: "15", context:backgroundContext)
      _ = FavoriteStation(name: "Mt Pleasant St", address: "Broadway St", bikes: "11", docks: "15", context: backgroundContext)
      _ = FavoriteStation(name: "Mt Auburn", address: "Mt Auburn", bikes: "14", docks: "19", context: backgroundContext)

      try! backgroundContext.save()
    }

    let mainContext = appDelegate.dataStack.mainContext

    let objects = self.fetch(forEntityName: String(describing: FavoriteStation.self), in: mainContext)
    log.info("objects.count: \(objects.count)")
    objects.each {
      if let favorite = ($0 as? FavoriteStation) {
        if let stationName = favorite.stationName {
          print("favorite Station Name: \(stationName)")
        }
      }
      self.tableData.append($0 as! FavoriteStation)
    }
  }

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
