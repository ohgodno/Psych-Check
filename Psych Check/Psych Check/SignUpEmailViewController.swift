//
//  SignUpEmailViewController.swift
//  Psych Check
//
//  Created by Harr on 2/26/17.
//  Copyright © 2017 Harrison Crandall. All rights reserved.
//

import UIKit
import Foundation
import EZSwiftExtensions
import AnimatedTextInput
import FirebaseAnalytics
import FirebaseAuth

class SignUpEmailViewController: UIViewController, AnimatedTextInputDelegate {
	
	@IBAction func returnToSignInButton(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	// MARK: Segues
	
	func handleSuccess (forUser user: FIRUser) {
		// Log an event with Firebase Analytics. See FIREventNames.h for pre-defined event strings
		FIRAnalytics.logEvent(withName: kFIREventSignUp, parameters: nil)
		
		let newemail = user.email ?? "your email address"
		let alert = UIAlertController(title: "Success", message: "You have a new account for \(newemail)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {(action) in
			UserDefaults().set(user.email, forKey: "auth_emailaddress")
			UserDefaults().synchronize()
			self.performSegue(withIdentifier: "unwindFromSignIn", sender: self)
		}))
		self.present(alert, animated: true, completion: {() -> Void in })
	}
	
	// MARK: Sign Up
	
	@IBAction func signUpButtonTapped(_ sender: UIButton) {
		guard let email = emailTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		
		configureViewBusy()
		
		// Create a new user with Firebase using the email provider. Callback with FIRUser, Error with _code = FIRAuthErrorCode
		FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
			
			self.configureViewNotBusy()
			
			if let error = error, let errorCode = FIRAuthErrorCode(rawValue: error._code) {
				switch errorCode {
				case .errorCodeWeakPassword:
					let alert = UIAlertController(title: "Weak password", message: "The password you entered is not strong enough with varied characters. Please try a different password", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {(action) in }))
					self.present(alert, animated: true, completion: {() -> Void in })
				case .errorCodeEmailAlreadyInUse:
					let alert = UIAlertController(title: "Account exists", message: "An account with the email adress \(email) already exists. Either login with the password for that address or click the help button if you have forgotten your password", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {(action) in }))
					self.present(alert, animated: true, completion: {() -> Void in })
				case .errorCodeInvalidEmail:
					let alert = UIAlertController(title: "Incorrect Email Address", message: "The email address you entered doesn't appear to belong to an account. Please check your address and try again", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {(action) -> Void in }))
					self.present(alert, animated: true, completion: {() -> Void in })
				default:
					let alert = UIAlertController(title: "Error", message: "Here is the message from Firebase: \(error.localizedDescription)", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Whoops", style: .default, handler: {(action) -> Void in }))
					self.present(alert, animated: true, completion: {() -> Void in })
				}
				
				return
			}
			
			guard let user = user else {
				// This should never happen and would be an error with Firebase
				let alert = UIAlertController(title: "I'm Stumped", message: "Firebase returned no error message and no user", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Okay?", style: .default, handler: {(action) -> Void in }))
				self.present(alert, animated: true, completion: {() -> Void in })
				
				return
			}
			
			self.handleSuccess(forUser: user)
		}
	}
	
	
	// MARK: View Lifecycle
	
	@IBOutlet weak var emailTextField: AnimatedTextInput!
	@IBOutlet weak var passwordTextField: AnimatedTextInput!
	@IBOutlet weak var signUpButton: UIButton!
	
	func animatedTextInputDidChange(animatedTextInput: AnimatedTextInput) {
		configureViewEdit()
	}
	
	var busy = UIActivityIndicatorView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		emailTextField.delegate = self
		passwordTextField.delegate = self
		emailTextField.placeHolderText = "Email"
		emailTextField.type = .email
		emailTextField.style = MaterialTextInputStyle()
		passwordTextField.placeHolderText = "Password"
		passwordTextField.type = .password
		passwordTextField.style = MaterialTextInputStyle()
		
		busy = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: signUpButton.frame.height, height: signUpButton.frame.height))
		busy.activityIndicatorViewStyle = .white
		busy.center = signUpButton.center
		busy.hidesWhenStopped = true
		view.addSubview(busy)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.configureViewEdit()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func animatedTextInputShouldReturn(animatedTextInput: AnimatedTextInput) -> Bool {
		animatedTextInput.resignFirstResponder()
		return true
	}
	
	func configureView() {
		configureViewEdit()
	}
	
	func configureViewBusy () {
		signUpButton.isEnabled = false
		signUpButton.alpha = 0.33
		signUpButton.setTitle("", for: .disabled)
		busy.startAnimating()
	}
	
	func configureViewNotBusy () {
		busy.stopAnimating()
		signUpButton.setTitle("Sign Up", for: .disabled)
		signUpButton.isEnabled = true
		signUpButton.alpha = 1.0
	}
	
	func configureViewEdit () {
		if emailTextField.text == "" || passwordTextField.text == "" {
			signUpButton.isEnabled = false
			signUpButton.alpha = 0.33
		} else {
			signUpButton.isEnabled = true
			signUpButton.alpha = 1.0
		}
	}
	
	
	
	@IBAction func emailChanged(_ sender: UITextField) {
		configureViewEdit()
	}
	
	@IBAction func passwordChanged(_ sender: UITextField) {
		configureViewEdit()
	}
	
}
