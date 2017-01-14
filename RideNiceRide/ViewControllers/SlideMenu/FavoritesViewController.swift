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

class FavoritesViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  // swiftlint:disable force_cast
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  // swiftlint:enable force_cast
  
  var tableData: [FavoriteStation] = []
  
  
  // MARK: - View Lifecycle functions
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
//    generateStubTableDataOnBackgroundContext()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNavigationBarItem()
    
    let mainContext = appDelegate.dataStack.mainContext
    
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
  func generateStubTableDataOnBackgroundContext() {
    appDelegate.dataStack.performInNewBackgroundContext { (backgroundContext) in
      self.clearOutFavoriteData(in: backgroundContext)
      
      _ = FavoriteStation(stationName: "Huntington Ave", address1: "Brigham Cir", availableBikes: "6", totalDocks: "15", context:backgroundContext)
      _ = FavoriteStation(stationName: "Mt Pleasant St", address1: "Broadway St", availableBikes: "11", totalDocks: "15", context: backgroundContext)
      _ = FavoriteStation(stationName: "Mt Auburn", address1: "Mt Auburn", availableBikes: "14", totalDocks: "19", context: backgroundContext)
      
      try! backgroundContext.save()
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
extension FavoritesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tableData.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
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
    // add code here...
}
