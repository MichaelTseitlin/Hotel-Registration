//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/18/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//
import RealmSwift

class RoomType: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var shortName: String = ""
    @objc dynamic var price: Int = 0
    
    convenience init(id: Int, name: String, shortName: String, price: Int) {
        self.init()
        self.id = id
        self.name = name
        self.shortName = shortName
        self.price = price
    }
}

extension RoomType {
    static var all: [RoomType] {
        return [
            RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One King", shortName: "K", price: 209),
            RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)
        ]
    }
}
