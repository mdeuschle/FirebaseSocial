//
//  Posts.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/19/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import Foundation

class Posts {

    private var _postDescription: String!
    private var _imageUrl: String?
    private var _likes: Int!
    private var _userName: String!
    private var _postKey: String!

    var postDescription: String {

        return _postDescription
    }

    var imageUrl: String? {

        return _imageUrl
    }

    var like: Int {

        return _likes
    }

    var userName: String {

        return _userName
    }

    var postKey: String {

        return _postKey
    }

    init(postDescription: String, imageURL: String?, userName: String) {

        self._postDescription = postDescription
        self._imageUrl = imageURL
        self._userName = userName
    }

    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {

        self._postKey = postKey

        if let likes = dictionary["likes"] as? Int {

            self._likes = likes

        }

        if let imageUrl = dictionary["imageUrl"] as? String {

            self._imageUrl = imageUrl
        }

        if let desc = dictionary["description"] as? String {

            self._postDescription = desc
        }
    }
}
