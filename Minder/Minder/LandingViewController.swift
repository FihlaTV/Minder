//
//  LandingViewController.swift
//  Minder
//
//  Created by Ahmed Moalim on 7/15/17.
//  Copyright © 2017 Minder. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        if let email = txtEmail.text, let password = txtPassword.text,  validateEmail(email: email), validatePassword(password: password) {
            
            let params : NSDictionary = ["email" : email, "password" : password]
            //QueryService.getSearchResults(params)
            
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
