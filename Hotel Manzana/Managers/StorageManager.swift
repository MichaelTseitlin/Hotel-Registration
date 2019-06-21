//
//  StorageManager.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/20/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveData(_ registration: [Registration]) {
        try! realm.write {
            realm.add(registration)
        }
    }
    
    static func deleteData(_ registration: Registration) {
        try! realm.write {
            realm.delete(registration)
        }
    }
}
