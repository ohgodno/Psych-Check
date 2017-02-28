//  ViewController.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import UIKit
import Foundation
import EZSwiftExtensions
import Firebase
import GoogleSignIn
import AnimatedTextInput

var defaults: UserDefaults = UserDefaults()
var defaultsUser: UserDefaults = UserDefaults()

public class ViewController: UIViewController {

	@IBOutlet weak var startTestButton: UIButton!
	
	@IBAction func startTestButton(_ sender: Any) {
		print(getTest())
		let QVC = self.storyboard!.instantiateViewController(withIdentifier: "QuestionViewController")
		present(QVC, animated: true, completion: nil)
	}
	
	@IBAction func signOutButton(_ sender: Any) {
		try! FIRAuth.auth()!.signOut()
		
		let NC = self.storyboard!.instantiateViewController(withIdentifier: "navigationController")
		UIApplication.shared.keyWindow?.rootViewController = NC
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		defaults.set(true, forKey: "firstOpen")
		if defaults.bool(forKey: "firstOpen") {
			print("yes")
		}
	}

	public func getTest() -> String {
		return Scales.GDS().instructions
	}

	override public func didReceiveMemoryWarning() {	super.didReceiveMemoryWarning()	}
}



