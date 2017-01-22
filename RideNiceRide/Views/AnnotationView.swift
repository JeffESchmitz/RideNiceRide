//
//  AnnotationView.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 1/10/17.
//  Copyright © 2017 Jeff Schmitz. All rights reserved.
//

import MapKit

class AnnotationView: MKAnnotationView {
  class var identifier: String { return String.className(self) }

  override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

    let customAnnotation = (annotation as? CustomAnnotation)!

    let image: UIImage?
    switch customAnnotation.availableBikes {
    case 0:
      if customAnnotation.isStationLocked {
        image = #imageLiteral(resourceName: "redPin")
      } else {
        image = #imageLiteral(resourceName: "bluePin")
      }
    case 1...4:
      image = #imageLiteral(resourceName: "orangePin")
    case 5...9:
      image = #imageLiteral(resourceName: "lightGreenPin")
    case 10...16:
      image = #imageLiteral(resourceName: "greenPin")

    default:
      image = #imageLiteral(resourceName: "bluePin")
    }
    self.image = image

    let label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 17, height: 17)))
    label.textAlignment = .center
    label.textColor = UIColor.white
    label.text = customAnnotation.availableBikes <=  0 ? "" : String(Int(customAnnotation.availableBikes))
    label.font = label.font.withSize(12)
    //    label.backgroundColor = UIColor.lightGray // For UI Debugging
    self.addSubview(label)

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, with: event)
    if hitView != nil {
      self.superview?.bringSubview(toFront: self)
    }
    return hitView
  }

  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let rect = self.bounds
    var isInside: Bool = rect.contains(point)
    if !isInside {
      for view in self.subviews {
        isInside = view.frame.contains(point)
        if isInside {
          break
        }
      }
    }
    return isInside
  }
}
