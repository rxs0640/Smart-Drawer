//
//  UserConditions.swift
//  Smart-Drawer
//
//  Created by Admin on 2/18/17.
//  Copyright © 2017 Sr. Project. All rights reserved.
//

import Foundation
import Firebase

struct UserConditions {
    let key: String
    let name: String
    let user: String
    let loc: Int
    let ref: FIRDatabaseReference?
    
    init(name: String, user: String, loc: Int, key: String = "") {
        self.key = key
        self.name = name
        self.user = user
        self.loc = loc
        self.ref = nil
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        user = snapshotValue["user"] as! String
        loc = snapshotValue["loc"] as! Int
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "user": user,
            "loc": loc
        ]
    }
}
