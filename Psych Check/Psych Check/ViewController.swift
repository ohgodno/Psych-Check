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
import AlertOnboarding

public class ViewController: UIViewController, AlertOnboardingDelegate {
	
	@IBOutlet weak var startTestButton: UIButton!
	@IBAction func startTestButton(_ sender: Any) {
		let QVC = self.storyboard!.instantiateViewController(withIdentifier: "QuestionViewController")
		present(QVC, animated: true, completion: nil)
	}
	
	@IBAction func signOutButton(_ sender: Any) {
		GIDSignIn.sharedInstance().signOut()
		
		do {
			try FIRAuth.auth()?.signOut()
		} catch let signOutError as NSError {
			print ("Error signing out: %@", signOutError)
		}
		let NC = self.storyboard!.instantiateViewController(withIdentifier: "navigationController")
		UIApplication.shared.keyWindow?.rootViewController = NC
	}
	
	public var onboardingView: AlertOnboarding = AlertOnboarding()
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		setupAlertOnboarding()
	}
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	public func setupAlertOnboarding() {
		let arrayOfImage = ["PsychCheckBrainOutline", "PsychCheckBrainOutline", "PsychCheckBrainOutline"]
		let arrayOfTitle = ["WELCOME", "CHOOSE THE PLANET", "DEPARTURE"]
		let arrayOfDescription = ["Swipe left to continue\n➜",
		                          "Purchase tickets on hot tours to your favorite planet and fly to the most comfortable intergalactic spaceships of best companies",
		                          "In the process of flight you will be in cryogenic sleep and supply the body with all the necessary things for life"]
		
		onboardingView = AlertOnboarding(arrayOfImage: arrayOfImage, arrayOfTitle: arrayOfTitle, arrayOfDescription: arrayOfDescription)
//		onboardingView.show()
//		onboardingView.hide()
	}
	
	
	public func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int) {
		print("Onboarding skipped the \(currentStep) step and the max step he saw was the number \(maxStep)")
	}
	
	public func alertOnboardingCompleted() {
		print("Onboarding completed!")
	}
	
	public func alertOnboardingNext(_ nextStep: Int) {
		print("Next step triggered! \(nextStep)")
	}
}



