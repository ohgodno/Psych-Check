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
		button.superview?.superview?.bringSubview(toFront: button)
		button.animate(0.5, completion: { () -> () in
			if button == self.emailPasswordSignInButton {
				let authVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "SignInEmailViewController")
				authVC.transitioningDelegate = self
				self.present(authVC, animated: true, completion: nil)
			} else if button == self.googleSignInButton {
				GIDSignIn.sharedInstance().signIn()
			}
		})
	}
	
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		GIDSignIn.sharedInstance().uiDelegate = self
		for button in [emailPasswordSignInButton, googleSignInButton, twitterSignInButton, facebookSignInButton] {
			button!.normalCornerRadius = min(emailPasswordSignInButton.frame.width / 2 , emailPasswordSignInButton.frame.height / 2)
		}
	}
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		GIDSignIn.sharedInstance().uiDelegate = self
		checkAndDismiss(sender: "viewDidAppear")
		
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(PickSignInViewController.receiveAuthUINotification(_:)),
		                                       name: NSNotification.Name(rawValue: "AuthUINotification"),
		                                       object: nil)
	}
	
	
	public func checkAndDismiss(sender:String? = nil) {
		if FIRAuth.auth()?.currentUser != nil {
			print("✅✅✅ USER SIGNED IN ✅✅✅ (\(sender ?? ""))")
			let NC = self.storyboard?.instantiateViewController(withIdentifier: "navigationController")
			self.present(NC!, animated: true, completion: nil)
		} else {
			print("❎❎❎ USER NOT SIGNED IN ❎❎❎ (\(sender ?? ""))")
		}
	}
	
	public func receiveAuthUINotification(_ notification: NSNotification) {
		if notification.name.rawValue == "AuthUINotification" {
			if notification.userInfo != nil {
				guard let userInfo = notification.userInfo as? [String:String] else { return }
				print(userInfo["statusText"]! + "receiveAuthUINotification")
				googleSignInButton.startFinishAnimation(0, completion: {
					self.checkAndDismiss(sender: "receiveAuthUINotification")
				})
			}
		}
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self,
		                                          name: NSNotification.Name(rawValue: "AuthUINotification"),
		                                          object: nil)
	}
	
	public func firebaseLogin(_ credential: FIRAuthCredential) {
		if let user = FIRAuth.auth()?.currentUser {
			user.link(with: credential) { (user, error) in
				print("🔗🔗🔗 LINKED 🔗🔗🔗")
				if let error = error {
					self.showMessagePrompt(error.localizedDescription)
					return
				}
				self.checkAndDismiss(sender: "firebaseLogin/linked")
			}
		} else {
			FIRAuth.auth()?.signIn(with: credential) { (user, error) in
				print("✅✅✅ firebaseLogin SIGNED IN ✅✅✅")
				if let error = error {
					self.showMessagePrompt(error.localizedDescription)
					return
				}
				self.checkAndDismiss(sender: "firebaseLogin/signIn")
			}
		}
	}
	
	func showMessagePrompt(_ message: String) {
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
		alert.addAction(okAction)
		self.present(alert, animated: true, completion: { _ in })
	}
	
	
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return nil
	}
}
