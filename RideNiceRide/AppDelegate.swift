//
//  AppDelegate.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 10/27/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//
import UIKit
import Fabric
import Crashlytics
import GoogleMaps
import CoreData
import DATAStack
import Willow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  lazy var dataStack: DATAStack = DATAStack(modelName: "RideNiceRide")

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    //    WillowConfiguration.configure(appLogLevels: [.debug, .info, .event, .warn, .error], asynchronous: false)
    WillowConfiguration.configure(appLogLevels: [.info, .event, .warn, .error], asynchronous: false)

    // Override point for customization after application launch.
//    Fabric.with([Crashlytics.self])

    self.createMenuView()

    // Google Maps API key. Log into Google API Dev console (https://console.developers.google.com/apis), and create a new API key for app and add that key here.
      GMSServices.provideAPIKey(K.GoogleServices.APIKey)

    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    // Stops monitoring network reachability status changes
    ReachabilityManager.shared.stopMonitoring()
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    // Starts monitoring network reachability status changes
    ReachabilityManager.shared.startMonitoring()
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  fileprivate func createMenuView() {
    // create viewController code
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
    let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as? LeftViewController

    let navicationController: UINavigationController = UINavigationController(rootViewController: mainViewController!)

    // TODO: JES - 1.21.2017 - Extract the hex color values into a Constants file and reference in one place.
    UINavigationBar.appearance().barTintColor = UIColor(hex: "2BAF2B")
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

    leftViewController?.mainViewController = navicationController

    let slideMenuController = ExSlideMenuController(mainViewController: navicationController, leftMenuViewController: leftViewController!)
    slideMenuController.automaticallyAdjustsScrollViewInsets = true
    slideMenuController.delegate = mainViewController
    self.window?.backgroundColor = UIColor(hex: "eceef1")
    self.window?.rootViewController = slideMenuController
    self.window?.makeKeyAndVisible()
  }
}
