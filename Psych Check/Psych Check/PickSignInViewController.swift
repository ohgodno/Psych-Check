//  PickSignInViewController.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.


import UIKit
import Foundation
import EZSwiftExtensions
import Firebase
import GoogleSignIn
import TKSubmitTransitionSwift3

public class SignInSelection {
	var name: String! = ""
	var color: UIColor! = UIColor()
}

//Email Color: UIColor(hexString: "#BDBDBD")
//Google Color = UIColor(hexString: "#4285F4")
//Twitter Color = UIColor(hexString: "#1DA1F2")
//Facebook Color = UIColor(hexString: "#3B5998")

public var selectedSignIn: SignInSelection! = SignInSelection()

public class PickSignInViewController: UIViewController,UIViewControllerTransitioningDelegate,GIDSignInUIDelegate {
	
	@IBAction func unwindFromSignIn(segue: UIStoryboardSegue) {
		
	}
	
	@IBOutlet weak var emailPasswordSignInButton: TKTransitionSubmitButton!
	@IBOutlet weak var googleSignInButton: TKTransitionSubmitButton!
	@IBOutlet weak var twitterSignInButton: TKTransitionSubmitButton!
	@IBOutlet weak var facebookSignInButton: TKTransitionSubmitButton!
	
	
	@IBAction func emailPasswordSignInButton(_ sender: Any) {
		selectedSignIn.name = "Email/Password"
		selectedSignIn.color = UIColor(hexString: "#BDBDBD")
		signInButtonPressed(emailPasswordSignInButton)
	}
	
	@IBAction func googleSignInButton(_ sender: Any) {
		selectedSignIn.name = "Google"
		selectedSignIn.color = UIColor(hexString: "#4285F4")
		signInButtonPressed(googleSignInButton)
	}
	
	@IBAction func twitterSignInButton(_ sender: Any) {
		selectedSignIn.name = "Twitter"
		selectedSignIn.color = UIColor(hexString: "#1DA1F2")
		//		signInButtonPressed(twitterSignInButton)
	}
	
	@IBAction func facebookSignInButton(_ sender: Any) {
		selectedSignIn.name = "Facebook"
		selectedSignIn.color = UIColor(hexString: "#3B5998")
		//		signInButtonPressed(facebookSignInButton)
		
	}
	
	public func signInButtonPressed(_ button: TKTransitionSubmitButton) {
		button.superview?.bringSubview(toFront: button)
		button.animate(1, completion: { () -> () in
			if button == self.emailPasswordSignInButton {
				let authVC = SignInEmailViewController(nibName: "Authentication", bundle: nil)
				authVC.transitioningDelegate = self
			} else if button == self.googleSignInButton {
				GIDSignIn.sharedInstance().uiDelegate = self
				GIDSignIn.sharedInstance().signIn()
			}
		})
		if button == self.emailPasswordSignInButton {
			self.performSegue(withIdentifier: "showAuthSignIn", sender: self)
		}
	}
	
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		if FIRAuth.auth()?.currentUser != nil {
			print("should dismiss")
			let NC = self.storyboard?.instantiateViewController(withIdentifier: "navigationController")
			self.present(NC!, animated: true, completion: nil)
		}
		for button in [emailPasswordSignInButton, googleSignInButton, twitterSignInButton, facebookSignInButton] {
			button!.normalCornerRadius = min(emailPasswordSignInButton.frame.width / 2 , emailPasswordSignInButton.frame.height / 2)
		}
	}
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if FIRAuth.auth()?.currentUser != nil {
			print("should dismiss")
			let NC = self.storyboard?.instantiateViewController(withIdentifier: "navigationController")
			self.present(NC!, animated: true, completion: nil)
		}
		
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(PickSignInViewController.receiveAuthUINotification(_:)),
		                                       name: NSNotification.Name(rawValue: "AuthUINotification"),
		                                       object: nil)
	}
	
	
	
	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	public func receiveAuthUINotification(_ notification: NSNotification) {
		if notification.name.rawValue == "AuthUINotification" {
			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				print(userInfo["statusText"]!)
			}
		}
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self,
		                                          name: NSNotification.Name(rawValue: "AuthUINotification"),
		                                          object: nil)
	}
	
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return nil
	}
}
