//
//  GuestsTableViewCell.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/19/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class GuestsTableViewCell: UITableViewCell {
    
    @IBOutlet var photo: UIImageView! {
        didSet {
            photo.layer.cornerRadius = photo.frame.size.height / 2
            photo.clipsToBounds = true
        }
    }
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var dates: UILabel!
    
    func configuration(_ registration: Registration) {
        
        guard let imageData = registration.photo else { return }
        
        photo.image = UIImage(data: imageData)
        fullNameLabel.text = registration.firstName + " " + registration.lastName
        dates.text = "\(registration.checkInDate.appStringFromDateBy(dateFormat: "MMM d")) - \(registration.checkOutDate.appStringFromDateBy(dateFormat: "MMM d"))"
    }
}
