//
//  AuthViewController.swift
//  Psych Check
//
//  Created by Harr on 2/24/17.
//  Copyright © 2017 Harrison Crandall. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import GoogleSignIn
import AnimatedTextInput
import EZSwiftExtensions

public var shouldDismissPickVC: Bool = false

public class AuthViewController: UIViewController, GIDSignInUIDelegate {
	
	@IBAction func cancelButton(_ sender: UIButton) {
		self.dismiss(animated: true, completion: {
			print("❌❌❌ Cancelled ❌❌❌")
		})
	}
	
	@IBOutlet weak var statusLabel: UILabel!
	
	@IBOutlet var signInStackView: UIStackView!
	@IBOutlet var textInputs: [AnimatedTextInput]!
	@IBOutlet var submitButton: UIButton!
	@IBAction func submitButton(_ sender: Any) {
		FIRAuth.auth()?.signIn(withEmail: textInputs[0].text!, password: textInputs[1].text!) { (user, error) in
			print("🎉🎉🎉 SIGNED IN 🎉🎉🎉")
		}
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		print(selectedSignIn.name)
		if selectedSignIn.name == "Email/Password" {
			textInputs?[0].placeHolderText = "Email"
			textInputs?[0].type = .email
			textInputs?[0].style = MaterialTextInputStyle()
			textInputs?[1].placeHolderText = "Password"
			textInputs?[1].type = .password
			textInputs?[1].style = MaterialTextInputStyle()
			statusLabel.isHidden = true
		} else if selectedSignIn.name == "Google" {
			GIDSignIn.sharedInstance().uiDelegate = self
			
			NotificationCenter.default.addObserver(self,
			                                       selector: #selector(AuthViewController.receiveToggleAuthUINotification(_:)),
			                                       name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
			                                       object: nil)
			statusLabel.isHidden = false
			signInStackView.isHidden = true
			toggleAuthUI()
		} else {
			
		}
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if selectedSignIn.name == "Google" {
			GIDSignIn.sharedInstance().signIn()
		}
	}
	
	func toggleAuthUI() {
		if GIDSignIn.sharedInstance().hasAuthInKeychain() {
			// Signed in
			statusLabel.text = "🎉🎉🎉 SIGNED IN 🎉🎉🎉"
			print("🎉🎉🎉 SIGNED IN 🎉🎉🎉")
			defaultsUser.set(true, forKey: "isSignedIn")
		} else {
			statusLabel.text = "😢😢😢 NOT SIGNED IN 😢😢😢"
			print("😢😢😢 NOT SIGNED IN 😢😢😢")
			defaultsUser.set(false, forKey: "isSignedIn")
		}
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self,
		                                          name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
		                                          object: nil)
	}
	
	func receiveToggleAuthUINotification(_ notification: NSNotification) {
		if notification.name.rawValue == "ToggleAuthUINotification" {
			self.toggleAuthUI()
			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				statusLabel.text = String!(userInfo["statusText"]!)
				print("Status Text: \(notification)")
				print((defaultsUser.object(forKey: "userDict") as! Dictionary)["email"]!)
				shouldDismissPickVC = true
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				let nc = storyboard.instantiateViewController(withIdentifier: "navigationController") as! navigationController
				self.present(nc, animated: false, completion: nil)
			}
		}
	}
	
}



public func toggleAuthUI() -> Bool {
	defaultsUser.set(GIDSignIn.sharedInstance().hasAuthInKeychain(), forKey: "isSignedIn")
	return GIDSignIn.sharedInstance().hasAuthInKeychain()
}
