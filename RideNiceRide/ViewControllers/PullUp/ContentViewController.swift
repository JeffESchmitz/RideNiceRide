//
//  ContentViewController.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/14/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

import UIKit
import MapKit
import ISHPullUp
import Willow
import DATAStack
import CoreData
import PKHUD

/**
 *   This protocol allows you to set the height of the bottom ISHPullUpController.
 *   This is useful for adjusting the height from outside of PullUpController or user interact.
 *   i.e. in the event the main viewcontroller (or any other view controller) wants to set the height.
 */
protocol PullUpViewDelegate {
  func setPullUpViewHeight(bottomHeight: CGFloat, animated: Bool)
}

class ContentViewController: UIViewController
//, MKMapViewDelegate
{

  // MARK: - Properties (private)
  fileprivate var currentLocation: CLLocation? {
    didSet {
//      fetchWeatherData()
    }
  }
  
  // MARK: - Properties (public)
  var pullUpViewDelegate: PullUpViewDelegate?
  var bottomPanoramaViewDelegate: BottomPanoramaViewDelegate?

  unowned var dataStack: DATAStack
  lazy var hubwayAPI: HubwayAPI = HubwayAPI(dataStack: self.dataStack)
  

  var viewModel: ContentViewModel? {
    didSet {
      updateView()
    }
  }

  @IBOutlet weak var rootView: UIView!
  @IBOutlet weak var layoutAnnotationLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!

  
  // MARK: - View Life Cycle

  required init?(coder aDecoder: NSCoder) {
    //swiftlint:disable force_cast
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    self.dataStack = appdelegate.dataStack
    //swiftlint:enable force_cast
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    setupView()
    
    // Hard Code the location to Boston - obviously don't want this hard coded
    let location = CLLocationCoordinate2D(latitude: 42.360083, longitude: -71.05888)
    let span = MKCoordinateSpanMake(0.05, 0.05)
    let region = MKCoordinateRegion(center: location, span: span)
    self.mapView.setRegion(region, animated: true)

  }

  override func viewWillAppear(_ animated: Bool) {

//    fetchStationData()
    
    // TODO: JES - 1.4.2017 - REMOVE FOLLOWING CODE! Just for demonstration purposes
    HUD.show(.progress)
    
    hubwayAPI.getStations { (stations, error) in
      if let error = error {
        print(error)
        HUD.flash(.error, delay: 1.0)
      } else if let stations = stations {
        
        
        let stationsViewModels = self.convertStationsDataModelsToViewModels(stationsDataModels: stations)
        self.viewModel = ContentViewModel(hubwayData: stationsViewModels)
        
        self.makeAnnotationsAndPlot()
        
//        HUD.hide(afterDelay: 1.0)
        HUD.hide(animated: true)
      }
    }
  }

  
  // MARK: - View Methods
  
  private func setupView() {
    
    self.mapView.delegate = self

    layoutAnnotationLabel.layer.cornerRadius = 2
    // the mapView should use the rootView's layout margins to
    // correctly update the legal label and coordinate region
    mapView.preservesSuperviewLayoutMargins = true
    
  }

  private func makeAnnotationsAndPlot() {
    
    let annotations = self.makeAnnotationsFromStations()
    
    for annotation in annotations {
      self.mapView.addAnnotation(annotation)
    }
  }

  private func updateView() {
    
    if let viewModel = viewModel {
      // just for test debugging of viewmodel - replace by populating an Annotation here
      let numberOfStations = viewModel.hubwayData.count
      print("There are \(numberOfStations) number of Stations in Hubway.")
    }
  }

  
  // MARK: - Helper methods
  
  private func convertStationsDataModelsToViewModels(stationsDataModels: [Station]) -> [StationViewModel] {
    var result = [StationViewModel]()
    for stationDataModel in stationsDataModels {
      result.append(StationViewModel(station: stationDataModel))
    }
    return result
  }
  
  private func makeAnnotationsFromStations() -> [CustomAnnotation] {
//    var result = [MKPointAnnotation]()
    var result = [CustomAnnotation]()
    
    if let stations = self.viewModel?.hubwayData {
//    if self.items.count > 0 {
      if !stations.isEmpty {
//      for station in self.items {
        if let hubwayData = self.viewModel?.hubwayData {
          for station in hubwayData {
            let stationLat = CLLocationDegrees(station.station.latitude!)
            let stationLong = CLLocationDegrees(station.station.longitude!)
            let location = CLLocationCoordinate2D(latitude: stationLat!, longitude: stationLong!)
            let annotation = CustomAnnotation(coordinate: location)
            annotation.availableBikes = Int(station.availableBikes)!
            annotation.title = station.stationName
            annotation.stationName = station.stationName
            annotation.availableDocks = Int(station.availableDocks)!
            result.append(annotation)
          }
        }
      }
    }
    return result
  }

  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
}

extension ContentViewController: ISHPullUpContentDelegate {

  func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController contentVC: UIViewController) {

    // update edgeInsets
    rootView.layoutMargins = edgeInsets

    // call layoutIfNeeded right away to participate in animations.
    // This method may be called from within animation blocks
    rootView.layoutIfNeeded()
  }
}

extension ContentViewController: MKMapViewDelegate {

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

//    print("Inside \(#function)")
    
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
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//    print("Inside \(#function)")

    // Do stuff needed when selecting a Pin on the map
    pullUpViewDelegate?.setPullUpViewHeight(bottomHeight: 60, animated: true)
    //swiftlint:disable force_cast
    let annotation = ((view as! AnnotationView).annotation as? CustomAnnotation)
    print("annotation stationName: \(annotation?.stationName)")
    print("annotation latitude: \(annotation?.coordinate.latitude)")
    print("annotation longitude: \(annotation?.coordinate.longitude)")
    //swiftlint:enable force_cast
    if let moveToCoordinate = annotation?.coordinate {
      bottomPanoramaViewDelegate?.moveNearCoordinate(coordinate: moveToCoordinate)
    }
  }
  
  func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//    print("Inside \(#function)")
    
    // Do stuff needed when selecting a Pin on the map
  }
}
