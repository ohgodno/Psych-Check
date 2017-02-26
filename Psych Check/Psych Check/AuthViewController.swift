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
	}
	
	
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		if selectedSignIn.name == "Google" {
			GIDSignIn.sharedInstance().uiDelegate = self
			
			NotificationCenter.default.addObserver(self,
			                                       selector: #selector(AuthViewController.receiveToggleAuthUINotification(_:)),
			                                       name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
			                                       object: nil)
		}
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
			statusLabel.isHidden = false
			signInStackView.isHidden = true
			toggleAuthUI()
		} else {
			
		}
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		GIDSignIn.sharedInstance().signIn()
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
				let nc = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
				self.present(nc, animated: false, completion: nil)
			}
		}
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

public func toggleAuthUI() -> Bool {
	defaultsUser.set(GIDSignIn.sharedInstance().hasAuthInKeychain(), forKey: "isSignedIn")
	return GIDSignIn.sharedInstance().hasAuthInKeychain()
}
