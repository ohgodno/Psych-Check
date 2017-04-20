////
////  AccountCreatorViewController.swift
////  Psych Check
////
////  Created by Harr on 3/6/17.
////  Copyright © 2017 Harrison Crandall. All rights reserved.
////
//
//import UIKit
//import Foundation
//import EZSwiftExtensions
//import AnimatedTextInput
//import FirebaseAnalytics
//import FirebaseAuth
//
//class AccountCreatorViewController: UIViewController, AnimatedTextInputDelegate {
//	
//	@IBOutlet weak var firstNameTextField: AnimatedTextInput!
//	@IBOutlet weak var lastNameTextField: AnimatedTextInput!
//	@IBOutlet weak var birthdayTextField: AnimatedTextInput!
//	@IBOutlet weak var signUpButton: UIButton!
//	@IBAction func signUpButton(_ sender: Any) {
//		let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
//		changeRequest?.displayName = "\(firstNameTextField.text!) \(lastNameTextField.text!)"
//		changeRequest?.commitChanges() { (error) in
//			print(error?.localizedDescription)
//		}
//		
//	}
//	
//	var busy = UIActivityIndicatorView()
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		firstNameTextField.delegate = self
//		lastNameTextField.delegate = self
//		birthdayTextField.delegate = self
//		
//		firstNameTextField.placeHolderText = "First Name"
//		firstNameTextField.type = .standard
//		firstNameTextField.style = MaterialTextInputStyle()
//		
//		lastNameTextField.placeHolderText = "Last Name"
//		lastNameTextField.type = .standard
//		lastNameTextField.style = MaterialTextInputStyle()
//		
//		birthdayTextField.placeHolderText = "Confirm Password"
//		birthdayTextField.type = .numeric
//		birthdayTextField.style = MaterialTextInputStyle()
//	}
//	
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//		self.configureViewEdit()
//	}
//	
//	func configureViewBusy () {
//		signUpButton.isEnabled = false
//		signUpButton.alpha = 0.5
//		signUpButton.setTitle("Continue", for: .disabled)
//		busy.startAnimating()
//	}
//	
//	func configureViewNotBusy () {
//		busy.stopAnimating()
//		signUpButton.setTitle("Continue", for: .disabled)
//		signUpButton.isEnabled = true
//		signUpButton.alpha = 1.0
//	}
//	
//	func configureViewEdit () {
//		if (firstNameTextField.text?.isBlank)! || (lastNameTextField.text?.isBlank)! || (birthdayTextField.text?.isBlank)! {
//			signUpButton.isEnabled = false
//			signUpButton.alpha = 0.5
//		} else {
//			signUpButton.isEnabled = true
//			signUpButton.alpha = 1.0
//		}
//	}
//	
//	func animatedTextInputDidChange(animatedTextInput: AnimatedTextInput) {
//		configureViewEdit()
//	}
//	
//	func animatedTextInputShouldReturn(animatedTextInput: AnimatedTextInput) -> Bool {
//		let _ = animatedTextInput.resignFirstResponder()
//		return true
//	}
//}
