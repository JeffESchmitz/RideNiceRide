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

class MainViewController: ISHPullUpViewController, PullUpViewDelegate {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    commonInit()
  }

  private func commonInit() {
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

  // MARK: - PullUpViewDelegate
  func setPullUpViewHeight(bottomHeight: CGFloat, animated: Bool) {
    self.setBottomHeight(bottomHeight, animated: animated)
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
