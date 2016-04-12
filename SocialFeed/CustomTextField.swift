//
//  CustomTextField.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/11/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: shadowColor, green: shadowColor, blue: shadowColor, alpha: 0.1).CGColor
        layer.borderWidth = 1.0
    }

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }

    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }

}
