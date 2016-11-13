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

enum Asset: String {
  case Menu_Hamburger = "menu-hamburger"

  var image: Image {
    return Image(asset: self)
  }
}

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
