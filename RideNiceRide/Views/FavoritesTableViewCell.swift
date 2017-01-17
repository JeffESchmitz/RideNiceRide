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
      if let favoriteLat = favoriteStation.latitude, let favoriteLong = favoriteStation.longitude {
          if let latitude = CLLocationDegrees(favoriteLat), let longitude = CLLocationDegrees(favoriteLong) {
            setMapLocation(latitude: latitude, longitude: longitude, zoom: 0.005)
        }
      }
      self.addressLabel.text = favoriteStation.stAddress1
      self.nameLabel.text = favoriteStation.stationName
      self.bikesValueLabel.text = favoriteStation.availableBikes
      self.racksValueLabel.text = favoriteStation.totalDocks
    }
  }
  
//  func setMapLocation(mapView: MKMapView, latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Double = 1) {
  func setMapLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Double = 1) {
  
    // define the map zoom span
    let latitudZoomLevel: CLLocationDegrees = zoom
    let longitudZoomLevel: CLLocationDegrees = zoom
    let zoomSpan: MKCoordinateSpan = MKCoordinateSpanMake(latitudZoomLevel, longitudZoomLevel)
    
    // use latitud and longitud to create a location coordinate
    let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
    
    // define and set the region of our map using the zoom map and location
    let region: MKCoordinateRegion = MKCoordinateRegionMake(location, zoomSpan)
    mapView.setRegion(region, animated: true)
  }
}
