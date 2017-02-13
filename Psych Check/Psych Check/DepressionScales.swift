//  DepressionScales.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import Foundation

public protocol scalesFormat {
	var instructions: String! {get}
	var questions: [String]! {get}
	var answerType: Int {get}
	//	var options: [String]! {get}
	var scaleAnswers: [options] {get}
}

public struct options {
	var options: [String]!
	var points: [Int]!
}

public class Scales {
	
	// Geriatric Depression Scale
	public struct GDS {
		
		public var instructions = "Choose the best answer for how you have felt over the past week"
		
		public var questions: [String] = ["Are you basically satisfied with your life?",
		                                  "Have you dropped many of your activities and interests?",
		                                  "Do you feel that your life is empty?",
		                                  "Do you often get bored?",
		                                  "Are you in good spirits most of the time?",
		                                  "Are you afraid that something bad is going to happen to you?",
		                                  "Do you feel happy most of the time?",
		                                  "Do you often feel helpless?",
		                                  "Do you prefer to stay at home, rather than going out and doing new things?",
		                                  "Do you feel you have more problems with memory than most?",
		                                  "Do you think it is wonderful to be alive now?",
		                                  "Do you feel pretty worthless the way you are now?",
		                                  "Do you feel full of energy?",
		                                  "Do you feel that your situation is hopeless?",
		                                  "Do you think that most people are better off than you are?"]
		public var answerType: Int =  1 // Yes/No
		
		//		public var options: [[String]] = [["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"],
		//		                                  ["Yes","No"]]
		
		public var scaleAnswers: [options] = [options(options: ["Yes", "No"], points: [0,1]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [0,1]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [0,1]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [0,1]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [0,1]),
		                                 options(options: ["Yes", "No"], points: [1,0]),
		                                 options(options: ["Yes", "No"], points: [1,0])]
	}
	
	//	public class PHQ9: scalesFormat { // Patient Health Questionnaire
	//
	//		public var instructions: String! { get {
	//			return "Over the past 2 weeks, how often have you been bothered by any of the following problems?"
	//			}
	//		}
	//
	//		public var questions: [String]! { get {
	//			return ["Little interest or pleasure in doing things",
	//			        "Feeling down, depressed or hopeless",
	//			        "Trouble falling asleep, staying asleep, or sleeping too much",
	//			        "Feeling tired or having little energy","Poor appetite or overeating","Feeling bad about yourself - or that you’re a failure or have let yourself or your family down","Trouble concentrating on things, such as reading the newspaper or watching television",
	//			        "Moving or speaking so slowly that other people could have noticed. Or, the opposite - being so fidgety or restless that you have been moving around a lot more than usual",
	//			        "Thoughts that you would be better off dead or of hurting yourself in some way"]
	//			}
	//		}
	//
	//		public var answerType: Int { get {
	//			return 2 // Yes/No
	//			}
	//		}
	//
	//		public var options: [String]! { get {
	//			return ["Not At all",
	//			        "Several Days",
	//			        "More Than Half the Days",
	//			        "Nearly Every Day"]
	//			}
	//		}
	//
	//
	//
	//		public var flagAnswers: Array<Any> { get {
	//			return [[2,3],[2,3],[2,3],[2,3],[2,3],[2,3],[2,3],[2,3],[1,2,3]]
	//			}
	//		}
	//
	//		public var followUp: String! { get {
	//			return "If you checked off any problems, how dificult have those problems made it for you to Do your work, take care of things at home, or get along with other people?"
	//			}
	//		}
	//
	//		public var followUpHeaders: [String]! { get {
	//			return ["Not difficult at all",
	//			        "Somewhat difficult",
	//			        "Very difficult",
	//			        "Extremely difficult"]
	//			}
	//		}
	//	}
}

public class results {
	public var depressionScale: String!
	public var answersGiven: [String:Any] = [:]
	public var totalScore: Int = 0
	public var problemScore: Int = 0
}
