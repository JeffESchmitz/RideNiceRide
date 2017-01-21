//
//  BottomViewController.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/17/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

import UIKit
import ISHPullUp
import MapKit
import GoogleMaps
import Willow

enum FavoriteViewState: Int {
  case unknown
  case addFavoriteStation
  case removeFavoriteStation
}

// TODO: Move out to a Protocol's file? Maybe, maybe not?
/**
 *   This protocol allows you to gain access to the Google PanoramaView nested inside the BottomViewController.
 *   Basically, it's just call forwarding the same functions(with params) on the PanoramaView object.
 */
protocol PanoramaViewDelegate {
  func moveNearCoordinate(coordinate: CLLocationCoordinate2D)
  // didSelect annotationView
  // didDeselect annotationView
  func didSelect(StationViewModel viewModel: StationViewModel)
  func didDeselect()

}

protocol ManageFavoriteDelegate {
  func addFavoriteStation()
  func removeFavoriteStation()
}

class BottomViewController: UIViewController, PanoramaViewDelegate {

  // MARK: - Public properties
  @IBOutlet weak var handleView: ISHPullUpHandleView!
  @IBOutlet weak var rootView: UIView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var topLabel: UILabel!
  @IBOutlet weak var topView: UIView!
  @IBOutlet weak var panoramaView: UIView!
  @IBOutlet weak var addFavoriteButton: UIButton!

  var firstAppearanceCompleted = false
  weak var pullUpController: ISHPullUpViewController!
  var panoView: GMSPanoramaView?
  var manageFavoriteDelegate: ManageFavoriteDelegate?

  // allow the pullup to snap to the half-way point
  var halfWayPoint = CGFloat(0)

  // MARK: - Private properties
  fileprivate var addRemoveState = FavoriteViewState.unknown
  fileprivate var selectedStationViewModel: StationViewModel? {
    didSet {
      var titleText = ""
      if selectedStationViewModel == nil {
        titleText = addRemoveTextForState(.addFavoriteStation)
      } else {
        if let isAFavorite = selectedStationViewModel?.isStationAFavorite {
          if isAFavorite {
            titleText = addRemoveTextForState(.addFavoriteStation)
          } else {
            titleText = addRemoveTextForState(.removeFavoriteStation)
          }
        }
      }
      log.event("titleText: \(titleText)")
      addFavoriteButton.setTitle(titleText, for: .normal)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let screenWidth = UIScreen.main.bounds.width
    log.info("screenWidth: \(screenWidth)")
    let panoHeight = UIScreen.main.bounds.height * 0.3
    log.info("panoHeight: \(panoHeight)")

    let frameRect = CGRect(x: 0, y: 0, width: screenWidth, height: panoHeight)

    panoView = GMSPanoramaView(frame: frameRect)

    guard let panoView = panoView else {
      log.error("PanoramaView error - inside function '\(#function)'")
      return
    }
    self.panoramaView.frame = panoView.frame
    self.panoramaView.addSubview(panoView)
    self.panoramaView = panoView

    let centerOfBoston = CLLocationCoordinate2DMake(42.361145, -71.057083)
    panoView.moveNearCoordinate(centerOfBoston)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    firstAppearanceCompleted = true
  }

  @IBAction func favoriteTouched(_ sender: Any) {
    var titleText = ""
    switch addRemoveState {
    case .addFavoriteStation:
      titleText = addRemoveTextForState(.addFavoriteStation)
      manageFavoriteDelegate?.addFavoriteStation()
      addRemoveState = .removeFavoriteStation
    case .removeFavoriteStation:
      titleText = addRemoveTextForState(.removeFavoriteStation)
      manageFavoriteDelegate?.removeFavoriteStation()
      addRemoveState = .addFavoriteStation
    default:
      log.warn("An unknown state occured while tapping on the Add/Remove Favorite button")
    }
    log.event("titleText: \(titleText)")
    addFavoriteButton.setTitle(titleText, for: .normal)
  }

  private dynamic func handleTapGesture(gesture: UITapGestureRecognizer) {
    if pullUpController.isLocked {
      return
    }
    pullUpController.toggleState(animated: true)
  }

  private func addRemoveTextForState(_ state: FavoriteViewState) -> String {
    switch state {
    case .removeFavoriteStation:
      return "Add Favorite"
    case .addFavoriteStation:
      return "Remove Favorite"
    case .unknown:
      return "Unknown"
    }
  }


  // MARK: - BottomPanoramaViewDelegate
  func moveNearCoordinate(coordinate: CLLocationCoordinate2D) {
    log.event("Inside function \(#function) - lat: \(coordinate.latitude), lon: \(coordinate.longitude)")
    panoView?.moveNearCoordinate(coordinate)
  }

  func didSelect(StationViewModel viewModel: StationViewModel) {
    addRemoveState = .addFavoriteStation
    self.selectedStationViewModel = viewModel
  }

  func didDeselect() {
    addRemoveState = .removeFavoriteStation
    self.selectedStationViewModel = nil
  }
}

extension BottomViewController: GMSPanoramaViewDelegate {
  // MARK: - GMSPanoramaViewDelegate
  func panoramaView(_ view: GMSPanoramaView, error: Error, onMoveNearCoordinate coordinate: CLLocationCoordinate2D) {
    log.event("Moving near coordinate (\(coordinate.latitude),\(coordinate.longitude) error: \(error.localizedDescription)")
  }

  func panoramaView(_ view: GMSPanoramaView, error: Error, onMoveToPanoramaID panoramaID: String) {
    log.event("Moving to PanoID \(panoramaID) error: \(error.localizedDescription)")
  }

  func panoramaView(_ view: GMSPanoramaView, didMoveTo panorama: GMSPanorama?) {
    log.event("Moved to panoramaID: \(panorama?.panoramaID) coordinates: (\(panorama?.coordinate.latitude),\(panorama?.coordinate.longitude))")
  }
}

extension BottomViewController: ISHPullUpSizingDelegate {
  func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
    let totalHeight = rootView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
//    let totalHeight = CGFloat(359.0)

    // Allow the pullUp to snap to the half way point, calculate the cached
    // value here and perform the snapping in ..targetHeightForBottomViewController..
    halfWayPoint = totalHeight / 2.0
    return totalHeight
  }

  func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {
//    let height = topView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    let height = CGFloat(0)
    return height
  }

  func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
    // if around 30pt of the halfway point -> snap to it
    if abs(height - halfWayPoint) < 30 {
      return halfWayPoint
    }

    // default
    return height
  }

  func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forBottomViewController contentVC: UIViewController) {
    scrollView.contentInset = edgeInsets
  }
}

extension BottomViewController: ISHPullUpStateDelegate {
  func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
    topLabel.text = textForState(state)
    handleView.setState(ISHPullUpHandleView.handleState(for: state), animated: firstAppearanceCompleted)
  }

  private func textForState(_ state: ISHPullUpState) -> String {
    switch state {
    case .collapsed:
      return "Drag up or tap"
    case .intermediate:
      return "Intermediate"
    case .dragging:
      return "Hold on"
    case .expanded:
      return "Drag down or tap"
    }
  }
}
