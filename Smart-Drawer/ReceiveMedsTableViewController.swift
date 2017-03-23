//
//  ReceiveMedsTableViewController.swift
//  Smart-Drawer
//
//  Created by Admin on 2/18/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import UIKit
import Firebase

class ReceiveMedsTableViewController: UITableViewController {
    
    // MARK: - Properties
    let ref = FIRDatabase.database().reference(withPath: "userCondition-items")
    var items: [UserConditions] = []
    var user: User!
    let current_user = FIRAuth.auth()?.currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        self.title = "Receive Medication"
        if (current_user == "username@firebase.com") {
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(BackBtnActn))
        
        ref.observe(.value, with: { snapshot in
            var newItem: [UserConditions] = []
            
            for item in snapshot.children {
                let conditionItem = UserConditions(snapshot: item as! FIRDataSnapshot)
                newItem.append(conditionItem)
            }
            
            self.items = newItem
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let userCondition = items[indexPath.row]
        
        cell.textLabel?.text = userCondition.name

        // Configure the cell...

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    // MARK: - Actions
    func addItem(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Condition",
                                      message: "Add a new condition",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first,
                let text = textField.text else{return}
            guard let locField = alert.textFields?[1],
                let location: Int? = Int(locField.text!) else{return}
            
            let userCondition = UserConditions(name: text,
                                               user: self.user.email,
                                               loc: location!)
            self.items.append(userCondition)
            self.tableView.reloadData()
            let userConditionRef = self.ref.child(text.lowercased())
            
            userConditionRef.setValue(userCondition.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField {
            textCondition in textCondition.placeholder = "Enter a condition"
        }
        alert.addTextField {
            textLocation in textLocation.placeholder = "Enter drawer number"
            textLocation.keyboardType = .numberPad
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func BackBtnActn(_ sender: AnyObject) {
        performSegue(withIdentifier: "ReceiveToDash", sender: self)
    }
    
    func Done(_ sender: AnyObject) {
        self.setEditing(false, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    
        if(editing == true) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addItem))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Done))
        }
        else  {
            self.navigationItem.rightBarButtonItem = self.editButtonItem
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(BackBtnActn))
        }
    }
    

    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "ReceiveToDash") {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        // Pass the selected object to the new view controller.
    }
}
