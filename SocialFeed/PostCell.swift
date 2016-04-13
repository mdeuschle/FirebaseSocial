//
//  PostCell.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/12/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var showcaseImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func drawRect(rect: CGRect) {
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true

        showcaseImage.clipsToBounds = true

    }

}
