//
//  DataService.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/12/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import Foundation
import Firebase


class DataService {

    static let ds = DataService()

    private var _refBase = Firebase(url: "https://matts.firebaseio.com/")

    var refbase: Firebase {

        return _refBase
    }
}
