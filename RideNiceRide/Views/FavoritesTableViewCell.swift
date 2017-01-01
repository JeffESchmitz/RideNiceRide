//
//  FavoritesTableViewCell.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/20/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

import UIKit
//import GooglePlaces
//import GoogleMaps
import MapKit
import Willow

class FavoritesTableViewCell: UITableViewCell {

  class var identifier: String { return String.className(self) }

  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bikesValueLabel: UILabel!
  @IBOutlet weak var racksValueLabel: UILabel!
//  @IBOutlet weak var panoramaView: UIView!
  @IBOutlet weak var mapView: MKMapView!

  // swiftlint:disable missing_docs
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  // swiftlint:enable missing_docs

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
//    initialize()
  }

  open func setup() {
  }

//  open func initialize() {
//    let frameRect = CGRect(x: 0, y: 0, width: 375, height: 104)
//    let panoView = GMSPanoramaView(frame: frameRect)
//
////    self.panoramaView.frame = panoView.frame
//    self.panoramaView.addSubview(panoView)
//    self.panoramaView = panoView
//
//    let testCoordinate = CLLocationCoordinate2DMake(-33.732, 150.312)
//    panoView.moveNearCoordinate(testCoordinate)
//  }


  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }


  var favoriteStation: FavoriteStation? {
    didSet {
      self.reloadData()
    }
  }

  func reloadData() {
    if let favoriteStation = self.favoriteStation {
        self.addressLabel.text = favoriteStation.stAddress1
        self.nameLabel.text = favoriteStation.stationName
        self.bikesValueLabel.text = favoriteStation.availableBikes
        self.racksValueLabel.text = favoriteStation.totalDocks
    }
  }
}
