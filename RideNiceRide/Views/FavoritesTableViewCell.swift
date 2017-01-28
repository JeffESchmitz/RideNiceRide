//
//  FavoritesTableViewCell.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/20/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//
import UIKit
import MapKit
import Willow

class FavoritesTableViewCell: UITableViewCell {

  // MARK: - Properties (public)
  class var identifier: String { return String.className(self) }

  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bikesValueLabel: UILabel!
  @IBOutlet weak var racksValueLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!

  var favoriteStation: FavoriteStation? {
    didSet {
      self.reloadData()
    }
  }

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

    initialize()
  }

  open func setup() {
  }

  open func initialize() {
    self.mapView.delegate = self
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func reloadData() {
    if let favoriteStation = self.favoriteStation {
      if let favoriteLat = favoriteStation.latitude, let favoriteLong = favoriteStation.longitude {
        if let latitude = CLLocationDegrees(favoriteLat), let longitude = CLLocationDegrees(favoriteLong) {
          setMapLocation(latitude: latitude, longitude: longitude, zoom: 0.005)

          // TODO: JES - 1.19.2017 - Refactor setMapLocation(::) and add this code to it. Will need to pass the favoriteStation instead of the lat/long coordinates
          let favoriteLocation = CLLocationCoordinate2DMake(latitude, longitude)
          let annotation = CustomAnnotation(coordinate: favoriteLocation)
          annotation.stationId = favoriteStation.id
          if let availableBikes = favoriteStation.availableBikes {
            annotation.availableBikes = Int(availableBikes)!
          }
          annotation.title = favoriteStation.stationName
          annotation.stationName = favoriteStation.stationName
          if let availableDocks = favoriteStation.availableDocks {
            annotation.availableDocks = Int(availableDocks)!
          }
          mapView.addAnnotation(annotation)
        }
      }
      self.addressLabel.text = favoriteStation.stAddress1
      self.nameLabel.text = favoriteStation.stationName
      self.bikesValueLabel.text = favoriteStation.availableBikes
      self.racksValueLabel.text = favoriteStation.totalDocks
    }
  }

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

extension FavoritesTableViewCell: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation {
      return nil
    }

    var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView.identifier)
    if annotationView == nil {
      annotationView = AnnotationView(annotation: annotation, reuseIdentifier: AnnotationView.identifier)
      annotationView?.canShowCallout = false
    } else {
      annotationView?.annotation = annotation
    }

    return annotationView
  }
}
