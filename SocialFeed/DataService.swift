//
//  DataService.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/12/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import Foundation
import Firebase

let urlBase = "https://matts.firebaseio.com/"


class DataService {

    static let ds = DataService()

    private var _refBase = Firebase(url: "\(urlBase)")
    private var _refUsers = Firebase(url: "\(urlBase)/users")
    private var _refPosts = Firebase(url: "\(urlBase)/posts")

    var refBase: Firebase {

        return _refBase
    }

    var refUsers: Firebase {

        return _refUsers
    }

    var refPosts: Firebase {

        return _refPosts
    }

    var refUserCurrent: Firebase {

        let uid = NSUserDefaults.standardUserDefaults().valueForKey(keyUid) as! String
        let user = Firebase(url: "\(urlBase)").childByAppendingPath("users").childByAppendingPath(uid)
        return user!
    }

    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {

        refUsers.childByAppendingPath(uid).setValue(user)
    }
}
