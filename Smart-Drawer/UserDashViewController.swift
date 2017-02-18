//
//  UserDashViewController.swift
//  Smart-Drawer
//
//  Created by Admin on 1/26/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import UIKit

class UserDashViewController: UIViewController {

    // MARK - init
    @IBOutlet weak var rcvmedbtn: UIButton!
    @IBOutlet weak var accoptbtn: UIButton!
    @IBOutlet weak var titlebar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Create Title label
        titlebar.title = "Welcome, USERNAME"
        //Create button labels
        rcvmedbtn.titleLabel?.textAlignment = NSTextAlignment.center
        rcvmedbtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        rcvmedbtn.setTitle("Receive\nMedicine", for: .normal)
        
        accoptbtn.titleLabel?.textAlignment = NSTextAlignment.center
        accoptbtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        accoptbtn.setTitle("Account\nOptions", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Logout(_ sender: Any) {
        performSegue(withIdentifier: "LogoutOfApp", sender: self)
    }
    
    // MARK: - Navigation
    
    @IBAction func GoToMedSel(_ sender: Any) {
        performSegue(withIdentifier: "DashToSelect", sender: self)
    }
    
    @IBAction func GoToAccOpt(_ sender: Any) {
        performSegue(withIdentifier: "DashToOptions", sender: self)
    }
    
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
