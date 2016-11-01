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
        self.profileImage.layoutIfNeeded()
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.profileImage.setRandomDownloadImage(80, height: 80)

        // swiftlint:disable todo
        // TODO: Rework/remove next two lines
        // swiftlint:enable todo
        self.backgroundImage.setRandomDownloadImage(Int(self.bounds.size.width), height: 160)
//        self.backgroundImage.image = UIImage(named: "hero")
    }
}
