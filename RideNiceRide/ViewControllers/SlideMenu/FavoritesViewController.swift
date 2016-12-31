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

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!

  let tableData: [Station] = [
    Station(name: "Huntington Ave", address: "Brigham Cir", bikes: "6", racks: "15"),
    Station(name: "Mt Pleasant St", address: "Broadway St", bikes: "11", racks: "14"),
    Station(name: "Mt Auburn", address: "Mt Auburn", bikes: "14", racks: "18")
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

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
//    let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
//    cell.textLabel?.text = self.tableData[indexPath.row].name

    // swiftlint:disable force_cast
    let cell = self.tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier) as! FavoritesTableViewCell
    // swiftlint:enable force_cast
    cell.station = self.tableData[indexPath.row]
    return cell
  }
}
