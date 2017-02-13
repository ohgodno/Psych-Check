//  QuestionViewController.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import Foundation
import UIKit
import EZSwiftExtensions

public struct Question {
	var questionString: String?
	var answers: [String]?
	var selectedAnswerIndex: Int?
}

public var questionNumber = 0
public var questions: [Question] = []


public class QuestionViewController: UIViewController {
	
	@IBOutlet weak var testProgress: UIProgressView!
	@IBOutlet weak var instructionsLabel: UILabel!
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var optionsStackView: UIStackView!
	@IBOutlet weak var option1Button: UIButton!
	@IBOutlet weak var option2Button: UIButton!
	@IBOutlet weak var option3Button: UIButton!
	@IBOutlet weak var option4Button: UIButton!
	@IBAction func option1Button(_ sender: Any) {
		nextQuestion()
		print(option1Button.titleLabel!)
		questions[questionNumber].selectedAnswerIndex = 1
	}
	@IBAction func option2Button(_ sender: Any) {
		nextQuestion()
		print(option2Button.titleLabel!)
		questions[questionNumber].selectedAnswerIndex = 2
	}
	@IBAction func option3Button(_ sender: Any) {
		nextQuestion()
		print(option3Button.titleLabel!)
		questions[questionNumber].selectedAnswerIndex = 3
	}
	@IBAction func option4Button(_ sender: Any) {
		nextQuestion()
		print(option4Button.titleLabel!)
		questions[questionNumber].selectedAnswerIndex = 4
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		for i in 0...Scales.GDS().questions.endIndex {
			questions[i] = Question(questionString: Scales.GDS().questions[i], answers: Scales.GDS().options[i], selectedAnswerIndex: nil)
		}
		updateQuestion()
	}
	
	public func nextQuestion() {
		if questionNumber == Scales.GDS().questions.endIndex-1 {
			print("done")
			testProgress.progressTintColor = UIColor.init(hexString: "#00C853")
			//			let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
			self.dismissVC(completion: {
				print("dismiss")
			})
			questionNumber = 0
		} else if questionNumber == Scales.GDS().questions.endIndex {
		} else {
			questionNumber+=1
			updateQuestion()
		}
	}
	
	public func updateQuestion() {
		var options = [option1Button, option2Button, option3Button, option4Button]
		instructionsLabel.text! = Scales.GDS().instructions
		instructionsLabel.sizeToFit()
		questionLabel.text = Scales.GDS().questions[questionNumber]
		questionLabel.sizeToFit()
		for i in Scales.GDS().options[questionNumber].endIndex..<4 {
			options[i]!.isHidden = true
		}
		for i in 0..<Scales.GDS().options[questionNumber].count {
			options[i]!.setTitle(Scales.GDS().options[questionNumber][i], for: .normal)
		}
		testProgress.setProgress(Float(questionNumber)/Float(Scales.GDS().questions.endIndex-1), animated: true)
	}
}
