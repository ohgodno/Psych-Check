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
import BorderedButton
import paper_onboarding

public class ViewController: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {
	
	public let onboarding = PaperOnboarding(itemsCount: 2)
	@IBOutlet weak var doneButton: BorderedButton!
	
	@IBAction func doneButton(_ sender: Any) {
		self.startTestButton.isHidden = false
		self.viewResultsButton.isHidden = false
		self.tipsLabel.isHidden = false
		self.tipsFlowerImageView.isHidden = false
		self.startTestButton.alpha = 0
		self.viewResultsButton.alpha = 0
		self.tipsLabel.alpha = 0
		self.tipsFlowerImageView.alpha = 0
		UIView.animate(withDuration: 1, animations: {
			self.onboarding.alpha = 0
			self.doneButton.alpha = 0

			self.startTestButton.alpha = 1
			self.viewResultsButton.alpha = 1
			self.tipsLabel.alpha = 1
			self.tipsFlowerImageView.alpha = 1
			UserDefaults().set(true, forKey: "completedOnboarding")
		}) { _ in
			self.onboarding.isHidden = true
			self.doneButton.isHidden = true
		}
	}
	
	@IBOutlet weak var startTestButton: UIButton!
	@IBAction func startTestButton(_ sender: Any) {
		print("Start Test Button Pressed")
		let QVC = self.storyboard!.instantiateViewController(withIdentifier: "QuestionViewController")
		navigationController?.pushViewController(QVC, animated: true)
	}
	
	@IBOutlet weak var viewResultsButton: UIButton!
	@IBAction func viewResultsButton(_ sender: Any) {
		print("View Results Button Pressed")
		let VSVC = self.storyboard!.instantiateViewController(withIdentifier: "ViewScalesViewController")
		navigationController?.pushViewController(VSVC, animated: true)
	}
	
	@IBAction func signOutButton(_ sender: Any) {
		GIDSignIn.sharedInstance().signOut()
		do {
			try FIRAuth.auth()?.signOut()
		} catch let signOutError as NSError {
			print ("Error signing out: %@", signOutError)
		}
		let NC = self.storyboard?.instantiateViewController(withIdentifier: "navigationController")
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = kCATransitionPush
		transition.subtype = kCATransitionFromLeft
		view.window!.layer.add(transition, forKey: kCATransition)
		present(NC!, animated: true, completion: nil)
	}
	
	@IBOutlet weak var tipsLabel: UILabel!
	@IBOutlet weak var tipsFlowerImageView: UIImageView!
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		if UserDefaults().value(forKey: "completedOnboarding") == nil {
			UserDefaults().set(false, forKey: "completedOnboarding")
		}
		if !UserDefaults().bool(forKey: "completedOnboarding") {
			startTestButton.isHidden = true
			viewResultsButton.isHidden = true
			tipsLabel.isHidden = true
			tipsFlowerImageView.isHidden = true
		} else {
			self.startTestButton.isHidden = false
			self.viewResultsButton.isHidden = false
			self.tipsLabel.isHidden = false
			self.tipsFlowerImageView.isHidden = false
		}
		doneButton.sizeToFit()
		doneButton.isHidden = true
		setupPaperOnboarding()
		tipsLabel.text = tips.last!
		tipsFlowerImageView.image = [#imageLiteral(resourceName: "sunflower"), #imageLiteral(resourceName: "hibiscus"), #imageLiteral(resourceName: "blossom")].random()
		tipsLabel.numberOfLines = 0
		tipsLabel.sizeToFit()
		guard let user = FIRAuth.auth()?.currentUser else { return }
		print(user.uid)
	}
	
	public func setupPaperOnboarding() {
		if !UserDefaults().bool(forKey: "completedOnboarding") {
			onboarding.dataSource = self
			onboarding.delegate = self
			onboarding.translatesAutoresizingMaskIntoConstraints = false
			view.insertSubview(onboarding, belowSubview: doneButton)
			for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
				view.addConstraint(NSLayoutConstraint(item: onboarding,
				                                      attribute: attribute,
				                                      relatedBy: .equal,
				                                      toItem: view,
				                                      attribute: attribute,
				                                      multiplier: 1,
				                                      constant: 0))
			}
		}
	}
	
	public func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
		let titleFont = UIFont.boldSystemFont(ofSize: 36)
		let descriptionFont = UIFont.systemFont(ofSize: 20)
		return [
			("PsychCheckBrainOutline", "Welcome", "Psych Check is an app designed to detect signs of Depression and Dementia\n\nSwipe left to continue",
			 "white dot",
			 UIColor(hexString: "#2196F3")!,
			 UIColor.white,
			 UIColor.white,
			 titleFont,
			 descriptionFont),
			("PsychCheckBrainOutline", "Disclaimer", "Psych Check results are NOT diagnoses. Contact your doctor if you have any symptoms of depression or dementia.",
			 "white dot",
			 UIColor(hexString: "#F44336")!,
			 UIColor.white,
			 UIColor.white,
			 titleFont,
			 descriptionFont)
			][index]
	}
	
	public func onboardingItemsCount() -> Int {
		return 2
	}
	
	public func onboardingWillTransitonToIndex(_ index: Int) {
		if index == 1 {
			print("button not hidden")
			doneButton.isHidden = false
		} else {
			print("button hidden")
			doneButton.isHidden = true
		}
	}
	
	public func onboardingDidTransitonToIndex(_ index: Int) {
		print("Onboard transitioned to \(index)")
	}
	
	public func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {	}
	
	public var tips: [String] = [
		"Quit smoking. Take this critical step to improve your health and combat aging. Smoking kills by causing cancer, strokes and heart failure. Smoking leads to erectile dysfunction in men due to atherosclerosis and to excessive wrinkling by attacking skin elasticity. Many resources are available to help you quit.",
		"Keep active. Do something to keep fit each dayósomething you enjoy that maintains strength, balance and flexibility and promotes cardiovascular health. Physical activity helps you stay at a healthy weight, prevent or control illness, sleep better, reduce stress, avoid falls and look and feel better, too.",
		"Eat well. Combined with physical activity, eating nutritious foods in the right amounts can help keep you healthy. Many illnesses, such as heart disease, obesity, high blood pressure, type 2 diabetes, and osteoporosis, can be prevented or controlled with dietary changes and exercise. Calcium and vitamin D supplements can help women prevent osteoporosis.",
		"Maintain a healthy weight. Extra weight increases your risk for heart disease, diabetes and high blood pressure. Use the Kaiser Permanente BMI (body mass index) calculator to find out what you should weigh for your height. Get to your healthy weight and stay there by eating right and keeping active. Replace sugary drinks with waterówater is calorie free!",
		"Prevent falls. We become vulnerable to falls as we age. Prevent falls and injury by removing loose carpet or throw rugs. Keep paths clear of electrical cords and clutter, and use night-lights in hallways and bathrooms. Did you know that people who walk barefoot fall more frequently? Wear shoes with good support to reduce the risk of falling.",
		"Stay up-to-date on immunizations and other health screenings. By age 50, women should begin mammography screening for breast cancer. Men can be checked for prostate cancer. Many preventive screenings are available. Those who are new to Medicare are entitled to a ìWelcome to Medicareî visit and all Medicare members to an annual wellness visit. Use these visits to discuss which preventative screenings and vaccinations are due.",
		"Prevent skin cancer. As we age, our skin grows thinner; it becomes drier and less elastic. Wrinkles appear, and cuts and bruises take longer to heal. Be sure to protect your skin from the sun. Too much sun and ultraviolet rays can cause skin cancer.",
		"Get regular dental, vision and hearing checkups. Your teeth and gums will last a lifetime if you care for them properlyóthat means daily brushing and flossing and getting regular dental checkups. By age 50, most people notice changes to their vision, including a gradual decline in the ability to see small print or focus on close objects. Common eye problems that can impair vision include cataracts and glaucoma. Hearing loss occurs commonly with aging, often due to exposure to loud noise.",
		"Manage stress. Try exercise or relaxation techniquesóperhaps meditation or yogaóas a means of coping. Make time for friends and social contacts and fun. Successful coping can affect our health and how we feel. Learn the role of positive thinking.",
		"Did you know that a lack of sunlight can lead to depression? Open your blinds and let the sunlight in for an immediate mood booster!",
		"If you aren't already on facebook, try setting up an account and connecting with people you know. It'll help pass the time and keep you up to date with the lives of all your friends!",
		"If possible sign up for group activities such as group walks or a card club. Not only do these activities keep you from boredom, you'll also meet new friends!"]
}
