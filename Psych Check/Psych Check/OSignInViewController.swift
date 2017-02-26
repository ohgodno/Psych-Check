//
//  NewSignInViewController.swift
//  Psych Check
//
//  Created by Harr on 2/24/17.
//  Copyright © 2017 Harrison Crandall. All rights reserved.
//

import UIKit
import Foundation
import EZSwiftExtensions
import Firebase
import AnimatedTextInput

public class OSignInViewController: UIViewController {
	
	@IBOutlet var signInStackView: UIStackView!
	@IBOutlet var textInputs: [AnimatedTextInput]!
	@IBOutlet var submitButton: UIButton!
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(hexString: "#ECEFF1")
		print(selectedSignIn.name)
		if selectedSignIn.name == "Email/Password" {
			textInputs?[0].placeHolderText = "Email"
			textInputs?[0].type = .email
			textInputs?[0].style = MaterialTextInputStyle()
			textInputs?[1].placeHolderText = "Password"
			textInputs?[1].type = .password
			textInputs?[1].style = MaterialTextInputStyle()
		}
	}

	public func onTapScreen() {
		self.dismiss(animated: true, completion: nil)
	}
	
	public func createEmailPasswordUser(email: String, password: String) {
		FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
			print("🎉")
			print("\(user) was created!")
		}
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
}
