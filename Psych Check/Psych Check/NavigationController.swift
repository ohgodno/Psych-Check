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

