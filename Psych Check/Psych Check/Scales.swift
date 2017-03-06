//  Scales.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import Foundation

public var disclaimer: String! = "This is NOT a diagnosis. Contact your doctor if you have any symptoms of depression."

public struct Question {
	var questionString: String!
	var options: [String]!
	var points: [Int]!
	var selectedAnswerString: String!
	var selectedAnswer: Int!
}

public protocol scalesFormat {
	var testName: String! { get set }
	var shortTestName: String! { get set }
	var instructions: String! { get set }
	var questions: [Question] { get set }
	var totalScore: Int { get set }
	var resultsInformation: String! { get set }
	func getScoreInformation() -> String!
	
}

public class Scales {
	
	// Geriatric Depression Scale
	public class GDS: scalesFormat {
		
		public var shortTestName: String! = "GDS"
		
		public var testName: String! = "Geriatric Depression Scale"
		
		public var totalScore = 0
		
		public var instructions: String! = "Choose the best answer for how you have felt over the past week"
		
		public var questions: [Question] = [Question(questionString: "Are you basically satisfied with your life?",
		                                             options: ["Yes", "No"],
		                                             points: [0,1],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Have you dropped many of your activities and interests?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you feel that your life is empty?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you often get bored?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Are you in good spirits most of the time?",
		                                             options: ["Yes", "No"],
		                                             points: [0,1],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Are you afraid that something bad is going to happen to you?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you feel happy most of the time?",
		                                             options: ["Yes", "No"],
		                                             points: [0,1],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you often feel helpless?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you prefer to stay at home, rather than going out and doing new things?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you feel you have more problems with memory than most?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you think it is wonderful to be alive now?",
		                                             options: ["Yes", "No"],
		                                             points: [0,1],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you feel pretty worthless the way you are now?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you feel full of energy?",
		                                             options: ["Yes", "No"],
		                                             points: [0,1],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you feel that your situation is hopeless?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you think that most people are better off than you are?",
		                                             options: ["Yes", "No"],
		                                             points: [1,0],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0)]
		
		public var resultsInformation: String! = "A score of 0 to 5 is normal. A score greater than 5 suggests depression. \(disclaimer!)"
		
		public func getScoreInformation() -> String! {
			return totalScore >= 5 ?
				"Your score of \(totalScore) suggests depression. \(disclaimer!)" :
			"Your score of \(totalScore) is less than 5 and suggests that you are fine. \(disclaimer!)"
		}
	}
	
	// Patient Health Questionnaire (PHQ-9)
	public class PHQ9: scalesFormat {
		
		public var shortTestName: String! = "PHQ9"
		
		public var testName: String! = "Patient Health Questionnaire (PHQ-9)"
		
		public var totalScore = 0
		
		public var instructions: String! = "Over the past 2 weeks, how often have you been bothered by any of the following problems?"
		
		public var questions: [Question] = [Question(questionString: "Little interest or pleasure in doing things",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Feeling down, depressed or hopeless",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Trouble falling asleep, staying asleep, or sleeping too much",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Feeling tired or having little energy",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Poor appetite or overeating",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Feeling bad about yourself - or that you’re a failure or have let yourself or your family down",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Trouble concentrating on things, such as reading the newspaper or watching television",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Moving or speaking so slowly that other people could have noticed, Or, the opposite - being so fidgety or restless that you have been moving around a lot more than usual",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Thoughts that you would be better off dead or of hurting yourself in some way",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0)]
		public var resultsInformation: String! =
			["A score ranging from 5-9 suggests minimal symptoms. It is recommended that the patient should be educated to call if worse, and return in one month",
			 "A score ranging from 10-14 suggests Minor Depression, Dysthymia, and or Major Depression (mild). It is recommended that the patient have support and or Antidepressant or psychotherapy if necessary",
			 "A score ranging from 15-19 suggests Major Depression (moderately severe). It is recommended that the patient receive antidepressants or psychotherapy",
			 "A score greater than 20 suggests Major Depression (severe). It is recommended that the patient receive antidepressants or psychotherapy"].joined(separator: "\n")
		
		public func getScoreInformation() -> String! {
			if (5...9).contains(totalScore) {
				return "Your score of \(totalScore) suggests minimal symptoms. It is recommended that the patient should be educated to call if worse, and return in one month. \(disclaimer!)"
			} else if (10...14).contains(totalScore) {
				return "Your score of \(totalScore) suggests Minor Depression, Dysthymia, and or Major Depression (mild). It is recommended that you get support and or Antidepressants or psychotherapy. Contact your doctor to find out about possible treatment. \(disclaimer!)"
			} else if (15...19).contains(totalScore) {
				return "Your score of \(totalScore) suggests Major Depression (moderately severe). It is recommended that you receive antidepressants or psychotherapy. Contact your doctor to find out about possible treatment. \(disclaimer!)"
			} else if totalScore >= 20 {
				return "Your score of \(totalScore) suggests suggests Major Depression (severe). It is recommended that you receive antidepressants or psychotherapy. Contact your doctor to find out about possible treatment. \(disclaimer!)"
			} else {
				return "Your score of \(totalScore) is less than 5 and suggests that you are fine. \(disclaimer!)"
			}
		}
	}
	
	// Burn’s Depression Checklist
	public class BDC: scalesFormat {
		
		public var shortTestName: String! = "BDC"
		
		public var testName: String! = "Burn’s Depression Checklist"
		
		public var totalScore = 0
		
		public var instructions: String! = "Select the response which best explains your feelings over the last week, including today"
		
		public var questions: [Question] = [Question(questionString: "Feeling sad or down in the dumps",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Feeling unhappy or blue",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Crying spells or tearfulness",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Feeling discouraged",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Feeling hopeless",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Low self-esteem",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Feeling worthless or inadequate",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Guilt or shame",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Criticizing yourself or blaming others",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Difficulty making decisions",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Loss of interest in family, friends, or colleagues",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Loneliness",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Spending less time with family or friends",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Loss of motivation",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Loss of interest in work or other activities",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Avoiding work or other activities",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Loss of pleasure or satisfaction in life",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Feeling tired",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Difficulty sleeping or sleeping too much",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Decreased or increased appetite",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Loss of interest in sex",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Worrying about your health",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you have any suicidal thoughts?",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Would you like to end your life?",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Do you have a plan for harming yourself?",
		                                             options: ["Not At all", "Somewhat", "Moderately", "A lot", "Extremely"],
		                                             points: [0,1,2,3,4],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0)]
		
		
		public var resultsInformation: String! =
			["A score ranging from 0-5 suggests no depression.",
			 "A score ranging from 6-10 suggests that the patient may be normal but unhappy.",
			 "A score ranging from 11-25 suggests mild depression.",
			 "A score greater than 26-50 suggests moderate depression.",
			 "A score greater than 51-75 suggests severe depression.",
			 "A score greater than 75-100 suggests extreme depression."].joined(separator: "\n")
		
		public func getScoreInformation() -> String! {
			if (6...10).contains(totalScore) {
				return "Your score of \(totalScore) suggests that you may be normal but unhappy. \(disclaimer!)"
			} else if (11...25).contains(totalScore) {
				return "Your score of \(totalScore) suggests mild depression. \(disclaimer!)"
			} else if (26...50).contains(totalScore) {
				return "Your score of \(totalScore) suggests moderate depression. \(disclaimer!)"
			}else if (51...75).contains(totalScore) {
				return "Your score of \(totalScore) suggests severe depression. \(disclaimer!)"
			} else if totalScore >= 76 {
				return "Your score of \(totalScore) suggests extreme depression. \(disclaimer!)"
			} else {
				return "Your score of \(totalScore) is less or equal to than 5 and suggests that you are fine. \(disclaimer!)"
			}
		}
	}
}

public class Results {
	public var depressionScale: String!
	public var answersGiven: [String:Any] = [:]
	public var totalScore: Int = 0
	public var resultsInformation: String!
}
