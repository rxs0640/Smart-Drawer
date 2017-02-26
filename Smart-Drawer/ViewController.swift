//
//  ViewController.swift
//  Smart-Drawer
//
//  Created by pc on 12/23/16.
//  Copyright © 2016 Sr. Project. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Init View
    @IBOutlet weak var usrPIN: UITextField!
    @IBOutlet weak var accountbtn: UIButton!
    @IBOutlet weak var btbtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        usrPIN.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    
        // Change Log In button text
        accountbtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        accountbtn.titleLabel?.textAlignment = NSTextAlignment.center
        accountbtn.setTitle("Minor Emergency?\nLog In or Create Account", for: .normal)
        
        // Change Bluetooth connect button text
        btbtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        btbtn.titleLabel?.textAlignment = NSTextAlignment.center
        btbtn.setTitle("1. connect to bluetooth here", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Init Functions
    
    @IBAction func DidInsertPINEnter(_ sender: Any) {
        DidInsertPin(sender: self)
    }
    
    // MARK: - Navigation
    @IBAction func DidInsertPin(_ sender: Any) {
        //Popup message
        let invalidPINController = UIAlertController(title: "Incorrect PIN", message: "Please re-enter the PIN", preferredStyle: UIAlertControllerStyle.alert)
        invalidPINController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        //PIN field controller
        if(usrPIN.text == "1234") {
            performSegue(withIdentifier:"PinToSearch", sender: self)
        }
        else {
            self.present(invalidPINController, animated: true, completion: nil)
            usrPIN.text = ""
        }
    }
    
    // Go To Account Screen
    @IBAction func GoToAcc(_ sender: Any) {
        
    performSegue(withIdentifier: "HomeToAccount", sender: self)
    }
    @IBAction func GoToBT(_ sender: Any) {
    performSegue(withIdentifier: "DEBUGBTCON", sender: self)
    }
    
    // Limits text field to 4 digits
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

}

