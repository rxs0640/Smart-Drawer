//
//  LoginViewController.swift
//  Smart-Drawer
//
//  Created by Admin on 1/26/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        FIRAuth.auth()!.signIn(withEmail: username.text!, password: password.text!) { user, error in
            if error != nil {
                self.present(invalidAccount, animated: true, completion: nil)
            }
            else {
                self.performSegue(withIdentifier:"LoginSuccess", sender: self)
            }
        }
        /*
         if(username.text == "username" && password.text == "password") {
         performSegue(withIdentifier:"LoginSuccess", sender: self)
         }*/
    }
    /*
    @IBAction func ForgotPWButton(_ sender: Any) {
    }
    */

    @IBAction func CreateAccount(_ sender: Any) {
        let alert = UIAlertController(title: "Register", message: "Register for a new account", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Register",
                                           style: .default)
        { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            FIRAuth.auth()!.createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    FIRAuth.auth()!.signIn(withEmail: self.username.text!, password: self.password.text!)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField {
            textEmail in textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField {
            textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func BackToSearch(_ sender: Any) {
        performSegue(withIdentifier: "BackToHome", sender: self)
    }

}
