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

class FavoritesTableViewCell: UITableViewCell, MKMapViewDelegate {

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
   setMapLocation(mapView: mapView, latitude: 36.548628, longitude: -4.6307649)
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

  func setMapLocation(mapView: MKMapView, latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Double = 1) {

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

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }


  var station: Station? {
    didSet {
      self.reloadData()
    }
  }

  func reloadData() {
    if let station = self.station {
      self.addressLabel.text = station.address
      self.nameLabel.text = station.name
      self.bikesValueLabel.text = station.bikes
      self.racksValueLabel.text = station.racks
    }
  }
}
