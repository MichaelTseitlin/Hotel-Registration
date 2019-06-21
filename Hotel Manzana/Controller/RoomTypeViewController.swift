//
//  RoomTypeViewController.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/18/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class RoomTypeViewController: UITableViewController {
    
    var selectedRoom: RoomType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "Room Selection"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        
        let roomType = RoomType.all[indexPath.row]
        
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "$ \(roomType.price)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
        selectedRoom = RoomType.all[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let navigationController = navigationController else { return }
        
        navigationController.popViewController(animated: true)
        
        guard let registrationViewController = navigationController.viewControllers.last as? RegistrationViewController else { return }
        
        registrationViewController.selectedRoom = selectedRoom
        registrationViewController.checkingEnabledButton()
    }
}
