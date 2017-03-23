//
//  UserDashViewController.swift
//  Smart-Drawer
//
//  Created by Admin on 1/26/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import UIKit
import Firebase

class UserDashViewController: UIViewController {

    // MARK - Properties
    var users: User!
    let usersRef = FIRDatabase.database().reference (withPath: "Online")
    
    // MARK - init
    @IBOutlet weak var rcvmedbtn: UIButton!
    @IBOutlet weak var accoptbtn: UIButton!
    @IBOutlet weak var titlebar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        FIRAuth.auth()!.addStateDidChangeListener {
            auth, user in
            guard let user = user else { return }
            self.users = User(authData: user)
            let currentUserRef = self.usersRef.child(self.users.uid)
            currentUserRef.setValue(self.users.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
        //Create Title label
        let username = FIRAuth.auth()?.currentUser?.email
        titlebar.title = "Welcome, " + username!
        //Create button labels
        rcvmedbtn.titleLabel?.textAlignment = NSTextAlignment.center
        rcvmedbtn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        if (username == "username@firebase.com") {
            rcvmedbtn.setTitle("Edit\nConditions", for: .normal)
        }
        else {
            rcvmedbtn.setTitle("Receive\nMedicine", for: .normal)
        }
        
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
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if (segue.identifier == "DashToSelect") {
            let nav = segue.destination as! UINavigationController
            let svc = nav.topViewController as! ReceiveMedsTableViewController
            svc.user = self.users as User
    
        }
        // Pass the selected object to the new view controller.
    }

}
