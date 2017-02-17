//  Scales.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import Foundation

public struct Question {
	var questionString: String!
	var options: [String]!
	var points: [Int]!
	var selectedAnswerString: String!
	var selectedAnswer: Int!
}

public class Scales {
	
	// Geriatric Depression Scale
	public struct GDS {
		public var totalScore = 0
		public var instructions = "Choose the best answer for how you have felt over the past week"
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
		public var resultsInformation: String! = "A score of 0 to 5 is normal. A score greater than 5 suggests depression. This is NOT a diagnosis. Contact your doctor if you have any symptoms of depression."
		
		public func diagnosis() -> String! {
			if totalScore >= 5 {
				return "You may have depression"
			} else {
				return "You should be fine"
			}
		}
	}
	
	// Patient Health Questionnaire
	public struct PHQ9 {
		var totalScore = 0
		public var instructions = "Over the past 2 weeks, how often have you been bothered by any of the following problems?"
		
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
		                                    Question(questionString: "Moving or speaking so slowly that other people could have noticed. Or, the opposite - being so fidgety or restless that you have been moving around a lot more than usual",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0),
		                                    Question(questionString: "Thoughts that you would be better off dead or of hurting yourself in some way",
		                                             options: ["Not At all", "Several Days", "More Than Half the Days", "Nearly Every Day"],
		                                             points: [0,1,2,3],
		                                             selectedAnswerString: "",
		                                             selectedAnswer: 0)]
	
	}
}

public class results {
	public var depressionScale: String!
	public var answersGiven: [String:Any] = [:]
	public var totalScore: Int = 0
	public var problemScore: Int = 0
}
