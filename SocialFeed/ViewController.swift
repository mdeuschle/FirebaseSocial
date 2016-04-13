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

    @IBOutlet var emailTextField: CustomTextField!
    @IBOutlet var passwordTextField: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if NSUserDefaults.standardUserDefaults().valueForKey(keyUid) != nil {

            self.performSegueWithIdentifier(loginSegue, sender: nil)
        }
    }


    @IBAction func fbButtonPressed(sender: UIButton!) {

        let fbLogin = FBSDKLoginManager()

        fbLogin.logInWithReadPermissions(["email"], fromViewController: self) { (fbResult: FBSDKLoginManagerLoginResult!, fbError: NSError!) -> Void in

            if fbError != nil {
                print("Facebook Login Failed. Error \(fbError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Succussfully logged in with facebook \(accessToken)")

                DataService.ds.refbase.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in

                    if error != nil {

                        print("login failed \(error)")
                    }

                    else {

                        print("login success! \(authData)")
                        NSUserDefaults.standardUserDefaults().setObject(authData.uid, forKey: keyUid)

                        self.performSegueWithIdentifier(loginSegue, sender: nil)
                    }


                })
                
            }
        }
    }
    @IBAction func emailButtonPressed(sender: UIButton) {

        if let email = emailTextField.text where email != "", let password = passwordTextField.text where password != "" {

            DataService.ds.refbase.authUser(email, password: password, withCompletionBlock: { error, authData in

                if error != nil {

                    print(error)

                    if error.code == acccountNonExist {

                        DataService.ds.refbase.createUser(email, password: password, withValueCompletionBlock: { error, result in

                            if error != nil {

                                self.showErrorAlert("Error creating account", message: "Please try again")
                            } else {

                                NSUserDefaults.standardUserDefaults().setObject(result[keyUid], forKey: keyUid)

                                DataService.ds.refbase.authUser(email, password: password, withCompletionBlock: nil)

                                self.performSegueWithIdentifier(loginSegue, sender: nil)
                            }
                        })
                    }

                    else {

                        self.showErrorAlert("Could not login", message: "Please try again")
                    }
                } else {

                    self.performSegueWithIdentifier(loginSegue, sender: nil)
                }
            })


        } else {

            showErrorAlert("Email required", message: "Please enter email and password")
        }
    }

    func showErrorAlert(title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}

