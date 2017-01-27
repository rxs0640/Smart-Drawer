//
//  LoginViewController.swift
//  Smart-Drawer
//
//  Created by Admin on 1/26/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Initialize
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    @IBAction func LoginButton(_ sender: Any) {
        //Popup message
        let invalidAccount = UIAlertController(title: "Incorrect username/password", message: "Please re-enter your information", preferredStyle: UIAlertControllerStyle.alert)
        invalidAccount.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        //Check login info
        if(username.text == "username" && password.text == "password") {
            performSegue(withIdentifier:"LoginSuccess", sender: self)
        }
        else {
            self.present(invalidAccount, animated: true, completion: nil)
        }
    }
    /*
    @IBAction func ForgotPWButton(_ sender: Any) {
    }

    @IBAction func CreateAccount(_ sender: Any) {
    }
    */
    @IBAction func BackToSearch(_ sender: Any) {
        performSegue(withIdentifier: "ReturnToSearch", sender: self)
    }

}
