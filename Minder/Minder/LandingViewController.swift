//
//  LandingViewController.swift
//  Minder
//
//  Created by Ahmed Moalim on 7/15/17.
//  Copyright © 2017 Minder. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    var txtEmail : String? = nil
    var txtPassword : String? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signIn(_ sender: Any) {
        if let username = txtEmail, let password = txtPassword,  validateEmail(email: username), validatePassword(password: password) {
            
            // Add code to check if email and username is in database
            
        } else {
            print("Please enter a valid username and password Combination")
        }
    }
    
    func validateEmail(email : String) ->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword(password : String) ->Bool{
        let passwordRegex = "(?=.*[a-zA-Z])(?=.*[0-9])\\S{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }

    
    
    
}
