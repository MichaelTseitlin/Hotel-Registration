//
//  RegistrationViewController.swift
//  Hotel Manzana
//
//  Created by Michael Tseitlin on 6/18/19.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class RegistrationViewController: UITableViewController {
    
    // MARK: - Properties
    
    var registration: Registration!
    var imageIsChanged = false
    
    let photoIndexPath = IndexPath(row: 0, section: 0)
    let checkInDateLabelIndexPath = IndexPath(row: 0, section: 2)
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 2)
    let checkOutDateLabelIndexPath = IndexPath(row: 2, section: 2)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 2)
    let roomTypeSelectionIndexPath = IndexPath(row: 0, section: 5)
    
    var isCheckInDatePickerShown = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var selectedRoom: RoomType? {
        didSet {
            roomTypeLabel.text = selectedRoom?.name
        }
    }
    
    // MARK: - @IBOutlets
    
    @IBOutlet var doneBarButton: UIBarButtonItem!
    
    @IBOutlet var photo: UIImageView! 
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet var wifiSwitch: UISwitch!
    
    @IBOutlet var roomTypeLabel: UILabel!
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        
        checkInDatePicker.isHidden = true
        checkOutDatePicker.isHidden = true
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        updateNumberOfGuests()
        
        setupDetailScreen()
        checkingEnabledButton()
        
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Custom Methods
    
    func saveRegistration() {
        
        let image = imageIsChanged ? photo.image : UIImage(named: "profilDefault")
        let imageData = image?.pngData()
        
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        guard let emailAddress = emailTextField.text else { return }
        
        let newRegistation = Registration(photo: imageData,
                                          firstName: firstName,
                                          lastName: lastName,
                                          emailAddress: emailAddress,
                                          checkInDate: checkInDatePicker.date,
                                          checkOutDate: checkOutDatePicker.date,
                                          numberOfAdults: Int(numberOfAdultsStepper.value),
                                          numberOfChildren: Int(numberOfChildrenStepper.value),
                                          roomType: selectedRoom!,
                                          wifi: wifiSwitch.isOn)
        
        if registration != nil {
            registration.photo = newRegistation.photo
            registration.firstName = newRegistation.firstName
            registration.lastName = newRegistation.lastName
            registration.emailAddress = newRegistation.emailAddress
            registration.checkInDate = newRegistation.checkInDate
            registration.checkOutDate = newRegistation.checkOutDate
            registration.numberOfAdults = newRegistation.numberOfAdults
            registration.numberOfChildren = newRegistation.numberOfChildren
            registration.roomType = newRegistation.roomType
            registration.wifi = newRegistation.wifi
        } else {
            StorageManager.saveData([newRegistation])
        }
    }
    
    private func setupDetailScreen() {
        
        guard registration != nil else { return }
        
        photo.image = UIImage(data: registration.photo!)
        firstNameTextField.text = registration.firstName
        lastNameTextField.text = registration.lastName
        emailTextField.text = registration.emailAddress
        checkInDatePicker.date = registration.checkInDate
        checkOutDatePicker.date = registration.checkOutDate
        numberOfAdultsStepper.value = Double(registration.numberOfAdults)
        numberOfChildrenStepper.value = Double(registration.numberOfChildren)
        wifiSwitch.isOn = registration.wifi
        roomTypeLabel.text = registration.roomType?.name
        
        firstNameTextField.isEnabled = false
        lastNameTextField.isEnabled = false
        emailTextField.isEnabled = false
        checkInDatePicker.isEnabled = false
        checkOutDatePicker.isEnabled = false
        numberOfAdultsStepper.isEnabled = false
        numberOfChildrenStepper.isEnabled = false
        wifiSwitch.isEnabled = false
        
        updateDateViews()
        updateNumberOfGuests()
    }
    
    private func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        checkInDateLabel.text = checkInDatePicker.date.appStringFromDateBy(dateFormat: "dd/MM/yyyy")
        checkOutDateLabel.text = checkOutDatePicker.date.appStringFromDateBy(dateFormat: "dd/MM/yyyy")
    }
    
    private func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func checkingEnabledButton() {
        
        if registration != nil {
            navigationItem.rightBarButtonItem = nil
        } else {
            doneBarButton.isEnabled = !firstNameTextField.text!.isEmpty
                && !lastNameTextField.text!.isEmpty
                && !emailTextField.text!.isEmpty
                && selectedRoom != nil
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - @IBActions
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        checkingEnabledButton()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension RegistrationViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
            
        case photoIndexPath:
            return 280
            
        case checkInDatePickerIndexPath:
            return isCheckInDatePickerShown ? UITableView.automaticDimension : 0
            
        case checkOutDatePickerIndexPath:
            return isCheckOutDatePickerShown ? UITableView.automaticDimension : 0
            
        default:
            return UITableView.automaticDimension
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
            
        case photoIndexPath:
            guard registration == nil else { return }
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let alertController = UIAlertController(title: "Choose your photo", message: nil, preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                self?.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { [weak self] _ in
                self?.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .default)
            
            alertController.addAction(camera)
            alertController.addAction(photo)
            alertController.addAction(cancel)
            
            present(alertController, animated: true)
            
        case checkInDateLabelIndexPath:
            guard registration == nil else { return }
            isCheckInDatePickerShown.toggle()
            
            if isCheckInDatePickerShown {
                isCheckOutDatePickerShown = false
            }
            
        case checkOutDateLabelIndexPath:
            guard registration == nil else { return }
            isCheckOutDatePickerShown.toggle()
            
            if isCheckOutDatePickerShown {
                isCheckInDatePickerShown = false
            }
            
        case roomTypeSelectionIndexPath:
            guard registration == nil else { return }
            
            let controller = storyboard!.instantiateViewController(withIdentifier: "RoomTypeID") as! RoomTypeViewController
            controller.selectedRoom = selectedRoom
            navigationController?.pushViewController(controller, animated: true)
            
        default:
            return
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
            
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }
        
        return false
    }
    
}

// MARK: - Work with image

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        photo.image = info[.editedImage] as? UIImage
        photo.contentMode = .scaleAspectFill
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
}
