//
//  MainViewController.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/9/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MainViewController: UIViewController {

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

}
extension MainViewController: SlideMenuControllerDelegate {

  func leftWillOpen() {
    print("SlideMenuControllerDelegate: leftWillOpen")
  }

  func leftDidOpen() {
    print("SlideMenuControllerDelegate: leftDidOpen")
  }

  func leftWillClose() {
    print("SlideMenuControllerDelegate: leftWillClose")
  }

  func leftDidClose() {
    print("SlideMenuControllerDelegate: leftDidClose")
  }

  func rightWillOpen() {
    print("SlideMenuControllerDelegate: rightWillOpen")
  }

  func rightDidOpen() {
    print("SlideMenuControllerDelegate: rightDidOpen")
  }

  func rightWillClose() {
    print("SlideMenuControllerDelegate: rightWillClose")
  }

  func rightDidClose() {
    print("SlideMenuControllerDelegate: rightDidClose")
  }
}
