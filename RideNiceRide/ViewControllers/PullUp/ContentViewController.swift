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

class ContentViewController: UIViewController {

  unowned var dataStack: DATAStack
  lazy var hubwayAPI: HubwayAPI = HubwayAPI(dataStack: self.dataStack)

  @IBOutlet weak var rootView: UIView!
  @IBOutlet weak var layoutAnnotationLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!

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
    layoutAnnotationLabel.layer.cornerRadius = 2
    // the mapView should use the rootView's layout margins to
    // correctly update the legal label and coordinate region
    mapView.preservesSuperviewLayoutMargins = true
  }

  override func viewDidAppear(_ animated: Bool) {
    log.info("in ContentViewController .viewDidAppear")

    hubwayAPI.getStations { (stations, error) in
      if let error = error {
        print(error)
      } else if let stations = stations {

        for station in stations {
          print("station name: \(station.stationName!)")
        }
        
//        // Configure the ??? Content ViewModel
//        self.viewModel = ContentViewModel(stationData: stations)
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
