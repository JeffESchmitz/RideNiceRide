//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {

  func setNavigationBarItem() {
//    self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
//    self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu-hamburger"))
    self.addLeftBarButtonWithImage(Asset.Menu_Hamburger.image)
    self.slideMenuController()?.removeLeftGestures()
    self.slideMenuController()?.removeRightGestures()
    self.slideMenuController()?.addLeftGestures()
    self.slideMenuController()?.addRightGestures()
  }

  func removeNavigationBarItem() {
    self.navigationItem.leftBarButtonItem = nil
    self.navigationItem.rightBarButtonItem = nil
    self.slideMenuController()?.removeLeftGestures()
    self.slideMenuController()?.removeRightGestures()
  }
  
//  // Reference: displayMessage taken from Ash Furrow's FunctionalReactiveAwesome repo - https://github.com/ashfurrow/FunctionalReactiveAwesome/blob/master/FunctionalReactiveAwesome/UIViewController%2BExtensions.swift
//  func displayMessage(message: String?, title: String?) {
//    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
//    
//    let ok = UIAlertAction(title: "OK", style: .Default, handler:
//      { [weak self] (_) -> Void in
//        self?.navigationController?.popToRootViewControllerAnimated(true)
//    })
//    
//    alert.addAction(ok)
//    
//    dispatch_async(dispatch_get_main_queue()) {
//      self.presentViewController(alert, animated: true, completion: nil)
//    }
//  }

}
