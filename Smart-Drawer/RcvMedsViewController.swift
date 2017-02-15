//
//  RcvMedsViewController.swift
//  Smart-Drawer
//
//  Created by Admin on 2/15/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import UIKit

class RcvMedsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func ReturnToDash(_ sender: Any) {
        performSegue(withIdentifier: "ReceiveToDash", sender: self)
    }
    
    @IBAction func GoToEdit(_ sender: Any) {
        performSegue(withIdentifier: "EditAvailableMeds", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        if (segue.identifier == "EditAvailableMeds") {
            
            let nextVC:EditConditionsViewController = (segue.destination as? EditConditionsViewController)!
                // Pass the selected object to the new view controller.
            nextVC.requester = "Receive"
        }
    }

}
