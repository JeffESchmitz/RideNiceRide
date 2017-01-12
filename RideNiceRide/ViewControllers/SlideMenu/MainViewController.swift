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

class MainViewController: ISHPullUpViewController, BottomViewDelegate {

  let logger = Logger()

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

    contentVC.bottomViewDelegate  = self
    bottomVC.pullUpController     = self
    contentDelegate = contentVC
    sizingDelegate  = bottomVC
    stateDelegate   = bottomVC
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
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

  // MARK: - BottomViewDelegate
  func setBottomViewHeight(bottomHeight: CGFloat, animated: Bool) {
    self.setBottomHeight(bottomHeight, animated: animated)
  }

}
extension MainViewController: SlideMenuControllerDelegate {

  func leftWillOpen() {
    logger.debug("SlideMenuControllerDelegate: leftWillOpen")
  }

  func leftDidOpen() {
    logger.debug("SlideMenuControllerDelegate: leftDidOpen")
  }

  func leftWillClose() {
    logger.debug("SlideMenuControllerDelegate: leftWillClose")
  }

  func leftDidClose() {
    logger.debug("SlideMenuControllerDelegate: leftDidClose")
  }

  func rightWillOpen() {
    logger.debug("SlideMenuControllerDelegate: rightWillOpen")
  }

  func rightDidOpen() {
    logger.debug("SlideMenuControllerDelegate: rightDidOpen")
  }

  func rightWillClose() {
    logger.debug("SlideMenuControllerDelegate: rightWillClose")
  }

  func rightDidClose() {
    logger.debug("SlideMenuControllerDelegate: rightDidClose")
  }
}
