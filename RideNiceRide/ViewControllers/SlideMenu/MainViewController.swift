//
//  MainViewController.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/9/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//
import UIKit
import SlideMenuControllerSwift
import Willow
import ISHPullUp
import ReachabilitySwift

class MainViewController: ISHPullUpViewController, PullUpViewDelegate {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    commonInit()
  }

  fileprivate func commonInit() {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    // swiftlint:disable force_cast
    let contentVC = storyBoard.instantiateViewController(withIdentifier: "content") as! ContentViewController
    let bottomVC = storyBoard.instantiateViewController(withIdentifier: "bottom") as! BottomViewController
    // swiftlint:enable force_cast

    contentViewController = contentVC
    bottomViewController  = bottomVC

    contentVC.pullUpViewDelegate    = self
    contentVC.panoramaViewDelegate  = bottomVC
    bottomVC.pullUpController       = self
    bottomVC.manageFavoriteDelegate = contentVC
    contentDelegate = contentVC
    sizingDelegate  = bottomVC
    stateDelegate   = bottomVC
  }

  // Mark: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.title = "Map"
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNavigationBarItem()
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonHandler))
    self.navigationItem.rightBarButtonItem = refresh
    ReachabilityManager.shared.addListener(listener: self)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    ReachabilityManager.shared.removeListener(listener: self)
  }

  // MARK: - PullUpViewDelegate
  func setPullUpViewHeight(bottomHeight: CGFloat, animated: Bool) {
    self.setBottomHeight(bottomHeight, animated: animated)
  }

  func refreshButtonHandler() {
    log.warn("Inside \(#function)")
    (self.contentViewController as? ContentViewController)?.reloadStationsOnMapView()
  }
}

extension MainViewController: SlideMenuControllerDelegate {

  func leftWillOpen() {
    log.event("SlideMenuControllerDelegate: leftWillOpen")
  }

  func leftDidOpen() {
    log.event("SlideMenuControllerDelegate: leftDidOpen")
  }

  func leftWillClose() {
    log.event("SlideMenuControllerDelegate: leftWillClose")
  }

  func leftDidClose() {
    log.event("SlideMenuControllerDelegate: leftDidClose")
  }

  func rightWillOpen() {
    log.event("SlideMenuControllerDelegate: rightWillOpen")
  }

  func rightDidOpen() {
    log.event("SlideMenuControllerDelegate: rightDidOpen")
  }

  func rightWillClose() {
    log.event("SlideMenuControllerDelegate: rightWillClose")
  }

  func rightDidClose() {
    log.event("SlideMenuControllerDelegate: rightDidClose")
  }
}

extension MainViewController: NetworkStatusListener {

  func networkStatusDidChange(status: Reachability.NetworkStatus) {
    switch status {
    case .notReachable:
      debugPrint("MainViewController: Network became unreachable")
      self.navigationItem.rightBarButtonItem?.isEnabled = false
    case .reachableViaWiFi:
      debugPrint("MainViewController: Network reachable through WiFi")
      self.navigationItem.rightBarButtonItem?.isEnabled = true
    case .reachableViaWWAN:
      debugPrint("MainViewController: Network reachable through Cellular Data")
      self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    // Update any UI elements here (disable buttons, labels etc.)
  }
}
