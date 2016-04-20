//
//  PostCell.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/12/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import Alamofire

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var showcaseImage: UIImageView!
    @IBOutlet weak var descrptionText: UITextView!
    @IBOutlet weak var likesLabel: UILabel!

    var post : Posts!
    var request: Request?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func drawRect(rect: CGRect) {
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true

        showcaseImage.clipsToBounds = true

    }

    func configureCell(post: Posts, img: UIImage?) {

        self.post = post
        self.descrptionText.text = post.postDescription
        self.likesLabel.text = "\(post.like)"

        if post.imageUrl != nil {

            if img != nil {

                self.showcaseImage.image = img
            } else {

                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in

                    if err == nil {

                        let img = UIImage(data: data!)!
                        self.showcaseImage.image = img
                        FeedViewController.imageCache.setObject(img, forKey: self.post.imageUrl!)
                    }
                })
            }
            
        } else {

            self.showcaseImage.hidden = true
        }
    }

}
