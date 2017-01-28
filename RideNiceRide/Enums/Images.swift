//
//  Images.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/12/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable type_body_length
enum Asset: String {
  case Bike = "bike"
  case BikeDock = "bikeDock"
  case BluePin = "bluePin"
  case GreenPin = "greenPin"
  case Hero = "hero"
  case LightGreenPin = "lightGreenPin"
  case Menu_Hamburger = "menu-hamburger"
  case OrangePin = "orangePin"
  case RedPin = "redPin"
  case Star_off = "star_off"
  case Star_on = "star_on"
  
  var image: Image {
    return Image(asset: self)
  }
}
// swiftlint:enable type_body_length
// swiftlint:enable trailing_whitespace
// swiftlint:enable line_length
// swiftlint:enable file_length

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
