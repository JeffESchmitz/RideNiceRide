//
//  ImageHeaderView.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 10/31/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

import UIKit

class ImageHeaderView: UIView {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "E0E0E0")
        self.backgroundImage.image = UIImage(named: "hero")
    }
}
