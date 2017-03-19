//
//  ConditionsListTableViewController.swift
//  Smart-Drawer
//
//  Created by Admin on 2/18/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import UIKit
import Firebase

class ConditionsListTableViewController: UITableViewController {
    
    //MARK: -Properties
    let ref = FIRDatabase.database().reference(withPath: "userCondition-items")
    var items: [UserConditions] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Search for Conditions"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backbtn))
        
        // Retrieve data from database
        ref.observe(.value, with: { snapshot in
            var newConditions: [UserConditions] = []
            
            for item in snapshot.children {
                let conditionItem = UserConditions(snapshot: item as! FIRDataSnapshot)
                newConditions.append(conditionItem)
            }
            
            self.items = newConditions
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellitems", for: indexPath)

        // Configure the cell...
        let userCondition = items[indexPath.row]
        cell.textLabel?.text = userCondition.name

        return cell
    }

    
    // MARK: - Navigation

    func backbtn(_ sender: AnyObject) {
        performSegue(withIdentifier: "SearchToHome", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "SearchToHome") {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        // Pass the selected object to the new view controller.
    }
    

}
