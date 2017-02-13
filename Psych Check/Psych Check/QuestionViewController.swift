//  QuestionViewController.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import Foundation
import UIKit
import EZSwiftExtensions

public struct Question {
	var instructions: String?
	var questionString: String?
	var answers: options
	var selectedAnswerIndex: Int?
}

public var questionNumber: Int = 0
public var questions: [Question] = []
var totalAnswerScore: Int = 0

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
		print(option1Button.titleLabel!.text!)
		questions[questionNumber].selectedAnswerIndex = 0
		totalAnswerScore += getPointsForAnswer(answer: option1Button.titleLabel!.text!)
		nextQuestion()
	}
	
	@IBAction func option2Button(_ sender: Any) {
		print(option2Button.titleLabel!.text!)
		questions[questionNumber].selectedAnswerIndex = 1
		totalAnswerScore += getPointsForAnswer(answer: option2Button.titleLabel!.text!)
		nextQuestion()
	}
	
	@IBAction func option3Button(_ sender: Any) {
		print(option3Button.titleLabel!.text!)
		questions[questionNumber].selectedAnswerIndex = 2
		totalAnswerScore += getPointsForAnswer(answer: option3Button.titleLabel!.text!)
		nextQuestion()
	}
	
	@IBAction func option4Button(_ sender: Any) {
		print(option4Button.titleLabel!.text!)
		questions[questionNumber].selectedAnswerIndex = 3
		totalAnswerScore += getPointsForAnswer(answer: option4Button.titleLabel!.text!)
		nextQuestion()
	}
	
	public func resetVariables(){
		questionNumber = 0
		questions = []
		totalAnswerScore = 0
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		resetVariables()
		for i in 0..<Scales.GDS().questions.endIndex {
			questions += [Question(instructions: Scales.GDS().instructions, questionString: Scales.GDS().questions[i], answers: Scales.GDS().scaleAnswers[i], selectedAnswerIndex: nil)]
		}
		updateQuestion()
	}
	
	public func nextQuestion() {
		if questionNumber == questions.endIndex-1 {
			print("done")
			testProgress.progressTintColor = UIColor.init(hexString: "#00C853")
			self.dismissVC(completion: {
				print("Results: ")
				for i in 0..<questions.endIndex {
					print("\(questions[i].questionString!)\t \(questions[i].answers.options[questions[i].selectedAnswerIndex!])")
				}
				print("Total Score: \(totalAnswerScore)/\(questions.count)")
			})
			questionNumber = 0
		} else if questionNumber == questions.endIndex {}
		else {
			questionNumber+=1
			updateQuestion()
		}
	}
	
	public func lastQuestion() {
		if questionNumber != 0 {
			
		}
	}
	
	public func updateQuestion() {
		print(totalAnswerScore)
		var options = [option1Button, option2Button, option3Button, option4Button]
		instructionsLabel.text! = questions[questionNumber].instructions!
		instructionsLabel.sizeToFit()
		questionLabel.text = questions[questionNumber].questionString
		questionLabel.sizeToFit()
		//		print(questions[1].answers.options?.endIndex)
		for i in questions.get(at: questionNumber)!.answers.options.endIndex..<4 {
			options[i]!.isHidden = true
		}
		for i in 0..<questions.get(at: questionNumber)!.answers.options.count {
			options[i]!.setTitle(questions[questionNumber].answers.options[i], for: .normal)
		}
		testProgress.setProgress(Float(questionNumber)/Float(questions.endIndex-1), animated: true)
	}
	
	public func getPointsForAnswer(answer:String!) -> Int {
		if (questions[questionNumber].answers.options?.contains(answer))! {
			return (questions[questionNumber].answers.points?[(questions[questionNumber].answers.options?.index(of: answer))!])!
		} else {
			return 0
		}
	}
}
