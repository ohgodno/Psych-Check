//
//  navigationController.swift
//  Psych Check
//
//  Created by Harr on 2/25/17.
//  Copyright © 2017 Harrison Crandall. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import GoogleSignIn

class navigationController : UINavigationController {
	
	@IBAction func unwindtoNC(segue: UIStoryboardSegue) {	}
	
//	let authVC = AuthViewController(nibName: "AuthViewController", bundle: nil)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if FIRAuth.auth()?.currentUser != nil {
			self.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: "ViewController"))!, animated: true)
		} else {
			self.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: "PickSignInViewController"))!, animated: true)
		}
	}
	
	//MARK: Authentication functions
	func logUserOut() {
		//Log user out of the app by showing the authentication screen, and then telling
		if let storyboard = self.storyboard {
			let authVC = storyboard.instantiateViewController(withIdentifier: "authViewController")
			self.setViewControllers([authVC], animated: true)
		} else {
			showAlert(title: "Logout Failed", message: "Unable to log out. Please try again later.", sourceVC: self)
			NSLog("Unable to load AuthViewController from storyboard and reset view controller stack.")
		}
		defaultsUser.set(false, forKey: "isSignedIn")
	}
	
	func logUserIn() {
		//Get the main storyboard so we can load the root view controller
		if let storyboard = self.storyboard {
			if defaultsUser.bool(forKey: "isSignedIn") {
				let noteVC = storyboard.instantiateViewController(withIdentifier: "notesViewController")
				self.setViewControllers([noteVC], animated: true)
			}
		}
	}
}

extension UIViewController {
	func performSegueToReturnBack()  {
		if let nav = self.navigationController {
			nav.popViewController(animated: true)
		} else {
			self.dismiss(animated: true, completion: nil)
		}
	}
}

