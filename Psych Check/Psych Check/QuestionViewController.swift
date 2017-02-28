//  QuestionViewController.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import Foundation
import UIKit
import EZSwiftExtensions

public struct test {
	var dateTaken: Date
	var totalScore: Int
	var responses: [Question]
}

public var questionNumber: Int = 0
public var scalesArray: [scalesFormat] = [Scales.GDS(),Scales.PHQ9()]
var scale: scalesFormat!

public class QuestionViewController: UIViewController {
	
	@IBOutlet weak var testProgress: UIProgressView!
	@IBOutlet weak var instructionsLabel: UILabel!
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var optionsStackView: UIStackView!
	@IBOutlet weak var option1Button: UIButton!
	@IBOutlet weak var option2Button: UIButton!
	@IBOutlet weak var option3Button: UIButton!
	@IBOutlet weak var option4Button: UIButton!
	
	@IBOutlet weak var previousQuestion: UIButton!
	@IBAction func previousQuestion(_ sender: Any) {
		lastQuestion()
	}
	
	
	@IBAction func option1Button(_ sender: Any) {
		print(option1Button.titleLabel!.text!)
		scale.questions[questionNumber].selectedAnswer = 0
		scale.questions[questionNumber].selectedAnswerString = option1Button.titleLabel!.text!
		scale.totalScore += getPointsForAnswer(answer: option1Button.titleLabel!.text!)
		nextQuestion()
	}
	
	@IBAction func option2Button(_ sender: Any) {
		print(option2Button.titleLabel!.text!)
		scale.questions[questionNumber].selectedAnswer = 1
		scale.questions[questionNumber].selectedAnswerString = option2Button.titleLabel!.text!
		scale.totalScore += getPointsForAnswer(answer: option2Button.titleLabel!.text!)
		nextQuestion()
	}
	
	@IBAction func option3Button(_ sender: Any) {
		print(option3Button.titleLabel!.text!)
		scale.questions[questionNumber].selectedAnswer = 2
		scale.questions[questionNumber].selectedAnswerString = option3Button.titleLabel!.text!
		scale.totalScore += getPointsForAnswer(answer: option3Button.titleLabel!.text!)
		nextQuestion()
	}
	
	@IBAction func option4Button(_ sender: Any) {
		print(option4Button.titleLabel!.text!)
		scale.questions[questionNumber].selectedAnswer = 3
		scale.questions[questionNumber].selectedAnswerString = option4Button.titleLabel!.text!
		scale.totalScore += getPointsForAnswer(answer: option4Button.titleLabel!.text!)
		nextQuestion()
	}
	
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		scale = scalesArray.random()
		scale.totalScore = 0
		updateQuestion()
	}
	
	public func nextQuestion() {
		if questionNumber == scale.questions.endIndex-1 {
			print("done")
			testFinished()
		} else if questionNumber == scale.questions.endIndex {}
		else {
			questionNumber+=1
			updateQuestion()
		}
	}
	
	public func testFinished() {
		testProgress.setProgress(1, animated: true)
		testProgress.progressTintColor = UIColor.init(hexString: "#00C853")
		createResults()
		self.dismiss(animated: true, completion: {
			print("Results: ")
			for i in 0..<scale.questions.endIndex {
				print("\(scale.questions[i].questionString!)\t \(scale.questions[i].options[scale.questions[i].selectedAnswer!])")
			}
			print("Total Score: \(scale.totalScore)")
			print(scale.resultsInformation)
			print(scale.getResultInformation())
		})
		questionNumber = 0
	}
	
	public func lastQuestion() {
		questionNumber -= 1
		scale.totalScore -= scale.questions[questionNumber].selectedAnswer
		updateQuestion()
	}
	
	public func updateQuestion() {
		print(scale.totalScore)
		var options = [option1Button, option2Button, option3Button, option4Button]
		instructionsLabel.text! = scale.instructions
		instructionsLabel.sizeToFit()
		questionLabel.text = scale.questions[questionNumber].questionString
		questionLabel.sizeToFit()
		for i in scale.questions[questionNumber].options.endIndex..<4 {
			options[i]!.isHidden = true
		}
		for i in 0..<scale.questions[questionNumber].options.count {
			options[i]!.setTitle(scale.questions[questionNumber].options[i], for: .normal)
		}
		previousQuestion.isHidden = questionNumber == 0
		testProgress.setProgress(Float(questionNumber)/Float(scale.questions.endIndex), animated: true)
	}
	
	public func getPointsForAnswer(answer:String!) -> Int {
		if (scale.questions[questionNumber].options?.contains(answer))! {
			return (scale.questions[questionNumber].points?[(scale.questions[questionNumber].options?.index(of: answer))!])!
		} else {
			return 0
		}
	}
	
	public func createResults() {
		
	}
}
