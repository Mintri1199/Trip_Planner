//
//  AddTripViewController.swift
//  Trip_Planner
//
//  Created by Jackson Ho on 4/19/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
// TODO: Change this later one when implemented Core Data
protocol CreateTrip {
    func createTrip(tripName: String)
}

class AddTripViewController: UIViewController {
    
    var delegate: CreateTrip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        configNavBar()
        setupView()
        tripTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Configure the navBar with title and buttons
    fileprivate func configNavBar() {
        self.title = "Add Trip"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTrip))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonTapped))
    }
    
    var tripLabel = TripLabel(frame: .zero)
    var tripTextField = TripNameTextField(frame: .zero)
    
    fileprivate func setupView() {
        view.addSubview(tripLabel)
        view.addSubview(tripTextField)
        
        NSLayoutConstraint.activate([
            tripLabel.heightAnchor.constraint(equalToConstant: view.bounds.height / 10),
            tripLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            tripLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tripLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tripTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tripTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            tripTextField.topAnchor.constraint(equalTo: tripLabel.bottomAnchor, constant: 20),
            tripTextField.heightAnchor.constraint(equalToConstant: view.bounds.height / 10)
            ])
    }
    
    // Check if there is text in the textField
    private func textFieldIsEmpty() -> Bool{
        if let text = tripTextField.text {
            let trimmingString = text.trimmingCharacters(in: .whitespaces)
            if trimmingString.isEmpty {
                return true
            } else {
                return false
            }
        }
        return false
    }
}

// All the @objc functions
extension AddTripViewController {
    
    // TODO: Change this later one when implemented Core Data
    @objc func addTrip() {
        if textFieldIsEmpty() {
            tripTextField.shake()
        } else {
            let tripName = tripTextField.text!
            delegate?.createTrip(tripName: tripName)
            navigationController?.popViewController(animated: true)
        }
    }
    // Return to the Main VC
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // Slide the screen up when the amount textfield is editing
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    // Slide the view down when text field is not editing
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}


extension AddTripViewController: UITextFieldDelegate {
    // Hide the keyboard when the user tap return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Stop the user from editing when the keyboard is hidden
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tripTextField.endEditing(true)
    }
}
