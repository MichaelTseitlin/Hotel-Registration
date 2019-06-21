//
//  MainTableViewController.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/19/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var registrations: Results<Registration>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registrations = realm.objects(Registration.self).sorted(byKeyPath: "checkInDate")
        
        if registrations.count == 0 {
            StorageManager.saveData(DataManager.loadExampleData())
        }
    }
    
    // MARK: - Table View Delegate and Data Source 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GuestsTableViewCell
        
        let registration = registrations[indexPath.row]
        
        cell.configuration(registration)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _, _ in
            
            let registration = self.registrations[indexPath.row]
            StorageManager.deleteData(registration)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [deleteAction]
    }
    
    // MARK: - Navigation
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        guard let registationVC = segue.source as? RegistrationViewController else { return }
        registationVC.saveRegistration()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let registationVC = segue.destination as? RegistrationViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let registration = registrations[indexPath.row]
        
        registationVC.registration = registration
        registationVC.title = "Details of Registration"
    }
}
