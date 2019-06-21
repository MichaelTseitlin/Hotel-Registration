//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/18/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation
import RealmSwift

class Registration: Object {
    @objc dynamic var photo: Data? = nil
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var emailAddress: String = ""
    
    @objc dynamic var checkInDate: Date = Date()
    @objc dynamic var checkOutDate: Date = Date()
    @objc dynamic var numberOfAdults: Int = 0
    @objc dynamic var numberOfChildren: Int = 0
    
    @objc dynamic var roomType: RoomType?
    @objc dynamic var wifi: Bool = false
    
    convenience init(photo: Data?, firstName: String, lastName: String, emailAddress: String, checkInDate: Date, checkOutDate: Date, numberOfAdults: Int, numberOfChildren: Int, roomType: RoomType, wifi: Bool) {
        self.init()
        self.photo = photo
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.numberOfAdults = numberOfAdults
        self.numberOfChildren = numberOfChildren
        self.roomType = roomType
        self.wifi = wifi
    }
}
