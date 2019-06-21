//
//  DataManager.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/20/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

struct DataManager {

    // This is only for example! I apologize for hardcode.
    
    static func loadExampleData() -> [Registration] {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.date(from: "08/10/2019")
        
        let imageEfimov = UIImage(named: "AlexeyEfimov")!
        let imageEfimovData = imageEfimov.pngData()
    
        let imageAkulov = UIImage(named: "IvanAkulov")!
        let imageAkulovData = imageAkulov.pngData()

        let imageParkhomenko = UIImage(named: "AlexeyParkhomenko")!
        let imageParkhomenkoData = imageParkhomenko.pngData()
        
        let imageTseitlin = UIImage(named: "MichaelTseitlin")!
        let imageTseitlinData = imageTseitlin.pngData()
        
        let imageBystruev = UIImage(named: "DenisBystruev")!
        let imageBystruevData = imageBystruev.pngData()

        return [
            Registration(photo: imageTseitlinData,
                         firstName: "Michael",
                         lastName: "Tseitlin",
                         emailAddress: "tseytlin21@gmail.com",
                         checkInDate: formatter.date(from: "08/08/2019")!,
                         checkOutDate: formatter.date(from: "20/08/2019")!,
                         numberOfAdults: 2,
                         numberOfChildren: 0,
                         roomType: RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                         wifi: true),
            Registration(photo: imageAkulovData,
                         firstName: "Ivan",
                         lastName: "Akulov",
                         emailAddress: "swiftbook.ru",
                         checkInDate: formatter.date(from: "03/09/2019")!,
                         checkOutDate: formatter.date(from: "23/09/2019")!,
                         numberOfAdults: 2,
                         numberOfChildren: 2,
                         roomType: RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309),
                         wifi: true),
            Registration(photo: imageEfimovData,
                         firstName: "Alexey",
                         lastName: "Efimov",
                         emailAddress: "efimov@gmail.com",
                         checkInDate: formatter.date(from: "01/07/2019")!,
                         checkOutDate: formatter.date(from: "08/07/2019")!,
                         numberOfAdults: 2,
                         numberOfChildren: 1,
                         roomType: RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309),
                         wifi: true),
            Registration(photo: imageParkhomenkoData,
                         firstName: "Alexey",
                         lastName: "Parkhomenko",
                         emailAddress: "parkhomenko@gmail.com",
                         checkInDate: formatter.date(from: "10/08/2019")!,
                         checkOutDate: formatter.date(from: "17/08/2019")!,
                         numberOfAdults: 2,
                         numberOfChildren: 0,
                         roomType: RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                         wifi: true),
            Registration(photo: imageBystruevData,
                         firstName: "Denis",
                         lastName: "Bystruev",
                         emailAddress: "bystruev@gmail.com",
                         checkInDate: formatter.date(from: "10/10/2019")!,
                         checkOutDate: formatter.date(from: "20/10/2019")!,
                         numberOfAdults: 2,
                         numberOfChildren: 2,
                         roomType: RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309),
                         wifi: true)
        ]
    }
}

