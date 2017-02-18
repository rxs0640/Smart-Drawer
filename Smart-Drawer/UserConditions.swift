//
//  UserConditions.swift
//  Smart-Drawer
//
//  Created by Admin on 2/18/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import Foundation
import Firebase

struct UserCondition {
    let key: String
    let name: String
    let user: String
    let ref: FIRDatabaseReference?
    
    init(name: String, user: String, key: String = "") {
        self.key = key
        self.name = name
        self.user = user
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        user = snapshotValue["user"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "user": user
        ]
    }
}
