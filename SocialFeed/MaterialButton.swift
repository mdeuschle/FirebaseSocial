//
//  MaterialButton.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/11/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {

        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: shadowColor, green: shadowColor, blue: shadowColor, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }
}
