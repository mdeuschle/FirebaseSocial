//
//  ViewController.swift
//  SocialFeed
//
//  Created by Matt Deuschle on 4/11/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fbButtonPressed(sender: UIButton!) {

        let fbLogin = FBSDKLoginManager()

        fbLogin.logInWithReadPermissions(["email"], fromViewController: self) { (fbResult: FBSDKLoginManagerLoginResult!, fbError: NSError!) -> Void in

            if fbError != nil {
                print("Facebook Login Failed. Error \(fbError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Succussfully logged in with facebook \(accessToken)")
            }
        }
    }
}

