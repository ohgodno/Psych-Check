//  ViewController.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import UIKit
import Foundation
import AlertOnboarding
import EZSwiftExtensions

public class ViewController: UIViewController, AlertOnboardingDelegate {

	var defaults: UserDefaults=UserDefaults()
	var onboardingAlertView: AlertOnboarding!
	let tutorialImages = ["PsychCheckSmile","PsychCheckSmile"]
	let tutorialTitles = ["Welcome to Psych Check", "look at this gay ass icon"]
	let tutorialDescriptions = ["kill yourself", "still kill urself"]
	
	@IBOutlet weak var startTestButton: UIButton!
	
	
	@IBAction func startTestButton(_ sender: Any) {
		print(getTest())
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		onboardingAlertView = AlertOnboarding(arrayOfImage: tutorialImages, arrayOfTitle: tutorialTitles, arrayOfDescription: tutorialDescriptions)
		onboardingAlertView.delegate = self
		defaults.set(true, forKey: "firstOpen")
		if defaults.bool(forKey: "firstOpen") {
			onboard()
			print("yes")
		}
	}

	public func onboard() {
		onboardingAlertView.percentageRatioHeight = 0.9
		onboardingAlertView.percentageRatioWidth = 0.9
		onboardingAlertView.titleSkipButton = "Skip"
		onboardingAlertView.titleGotItButton = "I will"
//		onboardingAlertView.show()
	}
	
	public func getTest() -> String {
		return Scales.GDS().instructions
	}

	override public func didReceiveMemoryWarning() {	super.didReceiveMemoryWarning()	}

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
