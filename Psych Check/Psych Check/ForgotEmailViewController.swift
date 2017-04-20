//
//  ForgotEmailViewController.swift
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

class ForgotEmailViewController: UIViewController, AnimatedTextInputDelegate {
	
	@IBAction func returnToSignInButton(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func sendButtonTapped(_ sender: UIButton) {
		guard let email = emailTextField.text else { return }
		
		configureViewBusy()
		
		// Sign in a user with Firebase using the email provider. Callback with FIRUser, Error with _code = FIRAuthErrorCode
		FIRAuth.auth()?.sendPasswordReset(withEmail: email) { (error) in
			
			self.configureViewNotBusy()
			
			if let error = error, let errorCode = FIRAuthErrorCode(rawValue: error._code) {
				switch errorCode {
				case .errorCodeUserNotFound:
					let alert = UIAlertController(title: "Incorrect address", message: "There is no record of an account with that email address. Please check that you have entered it correctly", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {(action) in }))
					self.present(alert, animated: true, completion: {() -> Void in })
				case .errorCodeInvalidEmail:
					let alert = UIAlertController(title: "Incorrect address", message: "The email address you entered doesn't appear to be a valid address. Please check your spelling and try again", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {(action) -> Void in }))
					self.present(alert, animated: true, completion: {() -> Void in })
				default:
					let alert = UIAlertController(title: "Error", message: "Here is the message from Firebase: \(error.localizedDescription)", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Okay, G", style: .default, handler: {(action) -> Void in }))
					self.present(alert, animated: true, completion: {() -> Void in })
				}
				
				return
			}
			
			self.handleSuccess()
		}
	}
	
	@IBOutlet weak var emailTextField: AnimatedTextInput!
	@IBOutlet weak var sendButton: UIButton!
	var busy = UIActivityIndicatorView()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		emailTextField.delegate = self
		emailTextField.placeHolderText = "Email"
		emailTextField.type = .email
		emailTextField.style = MaterialTextInputStyle()
		
		busy = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: sendButton.frame.height, height: sendButton.frame.height))
		busy.activityIndicatorViewStyle = .white
		busy.center = sendButton.center
		busy.hidesWhenStopped = true
		view.addSubview(busy)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.configureViewEdit()
	}
	
	func handleSuccess () {
		let alertController = UIAlertController(title: "Check your email", message: "A message to reset your password was sent to your email", preferredStyle: .alert)
		let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
			self.dismiss(animated: true, completion: nil)
//			self.present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationController"), animated: true, completion: nil)
		})
		alertController.addAction(OKAction)
		self.present(alertController, animated: true, completion: nil)
	}
	
	func configureViewBusy () {
		sendButton.isEnabled = false
		sendButton.alpha = 0.5
		sendButton.setTitle("", for: .disabled)
		busy.startAnimating()
	}
	
	func configureViewNotBusy () {
		busy.stopAnimating()
		sendButton.setTitle("Send Email with Link", for: .disabled)
		sendButton.isEnabled = true
		sendButton.alpha = 1.0
	}
	// If not optimistic UIs, can disable the UI with UIApplication.shared.beginIgnoringInteractionEvents()
	// To cover the view, see 28785715/how-to-display-an-activity-indicator-with-text-on-ios-8-with-swift and self.messageFrame.removeFromSuperview()
	
	func configureViewEdit () {
		if emailTextField.text == "" {
			sendButton.isEnabled = false
			sendButton.alpha = 0.5
		}
		else {
			sendButton.isEnabled = true
			sendButton.alpha = 1.0
		}
	}
	
	func animatedTextInputDidChange(animatedTextInput: AnimatedTextInput) {
		configureViewEdit()
	}
	
	func animatedTextInputShouldReturn(animatedTextInput: AnimatedTextInput) -> Bool {
		let _ = animatedTextInput.resignFirstResponder()
		return true
	}
}

