//
//  LoginViewController.swift
//  ParseStarterProject
//
//  Created by Carl Reyes on 5/3/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func logIn(sender: AnyObject) {
        var error = ""
        
        if username.text == "" || password.text == "" {
            
            error = "Please enter a username and password"
        }
        
        if error != "" {
            
            displayAlert("Error in login form", error: error)
            
        } else {
            PFUser.logInWithUsernameInBackground(username.text, password: password.text) {
                (user: PFUser?, loginError: NSError?) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                } else {
                    // The login failed. Check error to see why.
                    if let errorString = loginError!.userInfo?["error"] as? NSString {
                        error = errorString as String
                        self.displayAlert("Login Failed", error: error)
                    }
                }
            }
        }
        
    }
    @IBAction func backToSignUp(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        
    }
    
    func displayAlert(title: String, error: String) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
