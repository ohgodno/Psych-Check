//
//  SignInEmailViewController.swift
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

class SignInEmailViewController: UIViewController, AnimatedTextInputDelegate {
	
	@IBAction func canelButton(_ sender: Any) {
		performSegue(withIdentifier: "unwindFromSignIn", sender: self)
	}
	
	
	// Return point for any downstream views such as Sign Up
	@IBAction func unwindToSignIn(segue: UIStoryboardSegue) {
		if let user = FIRAuth.auth()?.currentUser {
			handleSuccess(forUser: user)
		}
	}
	
	@IBOutlet weak var emailTextField: AnimatedTextInput!
	@IBOutlet weak var passwordTextField: AnimatedTextInput!
	@IBOutlet weak var loginButton: UIButton!
	
	func animatedTextInputDidChange(animatedTextInput: AnimatedTextInput) {
		configureViewEdit()
	}
	
	var busy = UIActivityIndicatorView()
	
	@IBAction func loginButtonTapped(_ sender: UIButton) {
		guard let email = emailTextField.text else { return }
		guard let password = passwordTextField.text else { return }
		
		configureViewBusy()
		
		// Sign in a user with Firebase using the email provider. Callback with FIRUser, Error with _code = FIRAuthErrorCode
		FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
			
			self.configureViewNotBusy()
			
			if let error = error, let errorCode = FIRAuthErrorCode(rawValue: error._code) {
				switch errorCode {
				case .errorCodeWrongPassword,
				     .errorCodeInvalidCredential:
					let alert = UIAlertController(title: "Incorrect password for \(email)", message: "The password you entered is incorrect. Please try again", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {(action) in self.clearPassword() }))
					self.present(alert, animated: true, completion: {() -> Void in })
				case .errorCodeUserNotFound,
				     .errorCodeInvalidEmail:
					let alert = UIAlertController(title: "Incorrect Email Address", message: "The email address you entered doesn't appear to belong to an account. Please check your address and try again", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {(action) -> Void in
						self.clearPassword()
					}))
					self.present(alert, animated: true, completion: {() -> Void in })
					// TODO: case .errorCodeUserDisabled:
				// TODO: case .errorCodeTooManyRequests:
				default:
					let alert = UIAlertController(title: "Something is Fucked Up", message: "Here is the message from Firebase: \(error.localizedDescription)", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Okay, G", style: .default, handler: {(action) -> Void in
						self.clearPassword()
					}))
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		emailTextField.text = ""
		passwordTextField.text = ""
		emailTextField.delegate = self
		passwordTextField.delegate = self
		emailTextField.placeHolderText = "Email"
		emailTextField.type = .email
		emailTextField.style = MaterialTextInputStyle()
		passwordTextField.placeHolderText = "Password"
		passwordTextField.type = .password
		passwordTextField.style = MaterialTextInputStyle()
		
		busy = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: loginButton.frame.height, height: loginButton.frame.height))
		busy.activityIndicatorViewStyle = .white
		busy.center = loginButton.center
		busy.hidesWhenStopped = true
		view.addSubview(busy)
		
		if let lastemail = UserDefaults().string(forKey: "auth_emailaddress") {
			emailTextField.text = lastemail
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.configureViewEdit()
	}
	
	func handleSuccess (forUser user: FIRUser) {
		// Cache the email address with the iOS utility class
		UserDefaults().set(user.email, forKey: "auth_emailaddress")
		UserDefaults().synchronize()
		
		// Log an event with Firebase Analytics. See FIREventNames.h for pre-defined event strings
		FIRAnalytics.logEvent(withName: kFIREventLogin, parameters: nil)

		performSegue(withIdentifier: "unwindFromSignIn", sender: self)
	}
	
	func configureView() {
		configureViewEdit()
	}
	
	func configureViewBusy () {
		loginButton.isEnabled = false
		loginButton.alpha = 0.33
		loginButton.setTitle("", for: .disabled)
		busy.startAnimating()
	}
	
	func configureViewNotBusy () {
		busy.stopAnimating()
		loginButton.setTitle("Login", for: .disabled)
		loginButton.isEnabled = true
		loginButton.alpha = 1.0
	}
	
	func configureViewEdit () {
		if emailTextField.text == "" || passwordTextField.text == "" {
			loginButton.isEnabled = false
			loginButton.alpha = 0.33
		}
		else {
			loginButton.isEnabled = true
			loginButton.alpha = 1.0
		}
	}
	
	func clearPassword() {
		passwordTextField.text = ""
		configureViewEdit()
	}
}

public struct MaterialTextInputStyle: AnimatedTextInputStyle {
	public var activeColor: UIColor = UIColor(hexString: "#2196F3")!
	public var inactiveColor: UIColor = UIColor.black.withAlphaComponent(0.38)
	public var lineInactiveColor: UIColor = UIColor.black.withAlphaComponent(0.38)
	public var errorColor: UIColor = UIColor(hexString: "#F44336")!
	public var textInputFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
	public var textInputFontColor: UIColor = UIColor.black
	public var placeholderMinFontSize: CGFloat = 10
	public var counterLabelFont: UIFont? = UIFont.systemFont(ofSize: UIFont.systemFontSize)
	public let leftMargin: CGFloat = 25
	public let topMargin: CGFloat = 20
	public let rightMargin: CGFloat = 0
	public let bottomMargin: CGFloat = 10
	public let yHintPositionOffset: CGFloat = 7
	public let yPlaceholderPositionOffset: CGFloat = 0
}
