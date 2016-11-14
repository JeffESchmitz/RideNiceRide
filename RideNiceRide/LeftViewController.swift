//
//  LeftViewController.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/11/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

import UIKit
import Willow

enum LeftMenu: Int {
  case main = 0
  case favorites
  case rentalHistory
  case aroundYou
}

protocol LeftMenuProtocol {
  func changeViewController(_ menu: LeftMenu)
}

class LeftViewController: UIViewController {

  // swiftlint:disable variable_name
  let log = Logger()
  // swiftlint:enable variable_name

  @IBOutlet weak var tableView: UITableView!

  var menus = ["Main", "Favorites", "Rental History"]
  var mainViewController: UIViewController!
  var favoritesViewController: UIViewController!
  var rentalHistoryViewController: UIViewController!

  var imageHeaderView: ImageHeaderView!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.separatorColor = UIColor(hex: "e0e0e0")

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let favoritesVC = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController
    self.favoritesViewController = UINavigationController(rootViewController: favoritesVC!)

    let rentalHistoryVC = storyboard.instantiateViewController(withIdentifier: "RentalHistoryViewController") as? RentalHistoryViewController
    self.rentalHistoryViewController = UINavigationController(rootViewController: rentalHistoryVC!)

    tableView.registerCellClass(BaseTableViewCell.self)

    imageHeaderView = ImageHeaderView.loadNib()
    view.addSubview(imageHeaderView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    imageHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 160)
    view.layoutIfNeeded()
  }
}

extension LeftViewController: LeftMenuProtocol {
  func changeViewController(_ menu: LeftMenu) {
    switch menu {
    case .main:
      self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
    case .favorites:
      self.slideMenuController()?.changeMainViewController(self.favoritesViewController, close: true)
    case .rentalHistory:
      self.slideMenuController()?.changeMainViewController(self.rentalHistoryViewController, close: true)
    case .aroundYou:
      log.debug {"AroundYou not implemented yet!"}
    }
  }
}

extension LeftViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let menu = LeftMenu(rawValue: indexPath.row) {
      switch menu {
      case .main, .favorites, .rentalHistory, .aroundYou:
        return BaseTableViewCell.height()
      }
    }
    return 0
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let menu = LeftMenu(rawValue: indexPath.row) {
      self.changeViewController(menu)
    }
  }
}

extension LeftViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menus.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let menu = LeftMenu(rawValue: indexPath.row) {
      switch menu {
      case .main, .favorites, .rentalHistory, .aroundYou:
        let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        return cell
      }
    }
    return UITableViewCell()
  }
}