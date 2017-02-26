//  PickSignInViewController.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.


import UIKit
import Foundation
import EZSwiftExtensions
import TKSubmitTransitionSwift3

public class SignInSelection {
	var name: String! = ""
	var color: UIColor! = UIColor()
}

public var selectedSignIn: SignInSelection! = SignInSelection()

public class PickSignInViewController: UIViewController,UIViewControllerTransitioningDelegate {
		
	@IBOutlet weak var emailPasswordSignInButton: TKTransitionSubmitButton!
	@IBOutlet weak var googleSignInButton: TKTransitionSubmitButton!
	@IBOutlet weak var twitterSignInButton: TKTransitionSubmitButton!
	@IBOutlet weak var facebookSignInButton: TKTransitionSubmitButton!
	
	
	@IBAction func emailPasswordSignInButton(_ sender: Any) {
		selectedSignIn.name = "Email/Password"
		selectedSignIn.color = UIColor.lightGray
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
		button.animate(0.75, completion: { () -> () in
			let authVC = AuthViewController(nibName: "AuthViewController", bundle: nil)
			authVC.transitioningDelegate = self
			self.present(authVC, animated: true, completion: nil)
		})
	}
	
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		for button in [emailPasswordSignInButton, googleSignInButton, twitterSignInButton, facebookSignInButton] {
			button!.normalCornerRadius = min(emailPasswordSignInButton.frame.width / 2 , emailPasswordSignInButton.frame.height / 2)
		}
		//		emailPasswordSignInButton.backgroundColor = UIColor.lightGray
		//		googleSignInButton.backgroundColor = UIColor(hexString: "#4285F4")
		//		twitterSignInButton.backgroundColor = UIColor(hexString: "#1DA1F2")
		//		facebookSignInButton.backgroundColor = UIColor(hexString: "#3B5998")
	}
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)		
	}
	
	
	
	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TKFadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return nil
	}
}
