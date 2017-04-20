//
//  ViewScalesViewController.swift
//  Psych Check
//
//  Created by Harr on 3/13/17.
//  Copyright © 2017 Harrison Crandall. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import EZSwiftExtensions
import ScrollableGraphView

public class ViewScalesViewController: UIViewController {
	
	@IBAction func backButton(_ sender: Any) {
		let _ = navigationController?.popViewController(animated: true)
	}
	
	public var GDSScaleView: ScrollableGraphView! = ScrollableGraphView()
	public var PHQ9ScaleView: ScrollableGraphView! = ScrollableGraphView()
	public var BDCScaleView: ScrollableGraphView! = ScrollableGraphView()
	
	public var ref: FIRDatabaseReference! = FIRDatabase.database().reference()
	public var query: FIRDatabaseQuery?
	
	
	let formatter = DateFormatter()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		guard let user = FIRAuth.auth()?.currentUser else { return }
		ref = ref.child("users").child(user.uid)
		formatter.locale = Locale(identifier: "en-US")
		setupScaleViews()
	}
	
	public func setupScaleViews() {
		
		GDSScaleView = ScrollableGraphView(frame: CGRect(x:0,y:55,w:self.view.w,h:140))
		PHQ9ScaleView = ScrollableGraphView(frame: CGRect(x:0,y:235,w:self.view.w,h:140))
		BDCScaleView = ScrollableGraphView(frame: CGRect(x:0,y:415,w:self.view.w,h:140))
		
		let scaleViews = [GDSScaleView, PHQ9ScaleView, BDCScaleView]
		
		var dataArray: [[Double]] = []
		var labelArray: [[String]] = []
		
		for scaleView in scaleViews {
			formatScaleView(scaleView!, theme: "light")
		}
		getAllResults() { (GDSData, PHQ9Data, BDCData, GDSLabels, PHQ9Labels, BDCLabels) in
			dataArray = [GDSData, PHQ9Data, BDCData]
			labelArray = [GDSLabels, PHQ9Labels, BDCLabels]
			print(dataArray)
			print(labelArray)
			for i in 0..<scaleViews.endIndex {
				scaleViews[i]!.set(data: dataArray[i], withLabels: labelArray[i])
				self.view.addSubview(scaleViews[i]!)
			}
		}
	}
	
	public func formatScaleView(_ scaleView: ScrollableGraphView, theme: String) {
		if theme == "dark" {
			scaleView.backgroundFillColor = UIColor(hexString: "#333333")!
			scaleView.fillType = .gradient
			scaleView.fillGradientStartColor = UIColor(hexString: "#D50000")!
			scaleView.fillGradientEndColor = UIColor(hexString: "#388E3C")!
			scaleView.shouldFill = true
			scaleView.adaptAnimationType = .easeOut
			scaleView.animationDuration = 1
			scaleView.lineColor = UIColor.white
			scaleView.lineWidth = 3
			scaleView.lineStyle = .smooth
			scaleView.dataPointSize = 5
			scaleView.dataPointLabelFont = UIFont.boldSystemFont(ofSize: 10)
			scaleView.dataPointLabelColor = UIColor.white
			scaleView.dataPointFillColor = UIColor.white
			scaleView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 10)
			scaleView.referenceLineColor = UIColor.white.withAlphaComponent(0.5)
			scaleView.referenceLineLabelColor = UIColor.white
			scaleView.referenceLinePosition = .left
		} else if theme == "light" {
			scaleView.lineWidth = 3
			scaleView.lineColor = UIColor(hexString: "#2196F3")!
			scaleView.lineStyle = .smooth
			scaleView.backgroundFillColor = UIColor(hexString: "#EEEEEE")!
			scaleView.shouldFill = false
			scaleView.shouldRangeAlwaysStartAtZero = true
			scaleView.shouldDrawDataPoint = true
			scaleView.dataPointFillColor = UIColor(hexString: "#2196F3")!
			scaleView.dataPointType = .circle
			scaleView.dataPointSize = 4
			scaleView.shouldAdaptRange = false
			scaleView.shouldAnimateOnStartup = true
			scaleView.adaptAnimationType = .easeOut
			scaleView.animationDuration = 1
			scaleView.shouldShowReferenceLines = true
			scaleView.referenceLineColor = UIColor(hexString: "#BDBDBD")!
			scaleView.referenceLineThickness = 1
			scaleView.referenceLinePosition = .left
			scaleView.referenceLineLabelFont = UIFont.systemFont(ofSize: 12)
			scaleView.shouldShowReferenceLineUnits = false
			scaleView.shouldShowLabels = true
			scaleView.dataPointLabelFont = UIFont.systemFont(ofSize: 12)
			scaleView.dataPointLabelColor = UIColor(hexString: "#424242")!
		} else if theme == "blue" {
			scaleView.backgroundFillColor = UIColor(hexString: "#2196F3")!
			scaleView.shouldFill = false
			scaleView.adaptAnimationType = .easeOut
			scaleView.animationDuration = 1
			scaleView.lineColor = UIColor.white
			scaleView.lineWidth = 3
			scaleView.lineStyle = .smooth
			scaleView.dataPointSize = 5
			scaleView.dataPointLabelFont = UIFont.boldSystemFont(ofSize: 10)
			scaleView.dataPointLabelColor = UIColor.white
			scaleView.dataPointFillColor = UIColor.white
			scaleView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 10)
			scaleView.referenceLineColor = UIColor.white.withAlphaComponent(0.5)
			scaleView.referenceLineLabelColor = UIColor.white
			scaleView.referenceLinePosition = .left
		}
		if scaleView == GDSScaleView {
			scaleView.rangeMax = 15
		} else if scaleView == PHQ9ScaleView {
			scaleView.rangeMax = 27
		} else if scaleView == BDCScaleView {
			scaleView.rangeMax = 100
		}
	}
	
	public func getAllResults(completion: @escaping ([Double],[Double],[Double],[String],[String],[String]) -> Void) {
		
		var GDSData:  [Double] = []
		var PHQ9Data: [Double] = []
		var BDCData:  [Double] = []
		var GDSLabels:  [String] = []
		var PHQ9Labels: [String] = []
		var BDCLabels:  [String] = []
		
		ref.observeSingleEvent(of: .value, with: { snapshot in
			if !snapshot.exists() { print("doesnt exist"); return }
			print("exists")
			for child in snapshot.children {
				let test = (child as! FIRDataSnapshot).value as? [String : AnyObject] ?? [:]
				if test["shortTestName"] as? String == "GDS" {
					self.formatter.dateFormat = "MM-dd-yyyy hh:mm a"
					let dateString = self.formatter.date(from: test["testTime"]! as! String)
					self.formatter.dateFormat = "MM/dd"
					GDSData.append(test["totalScore"]! as! Double)
					GDSLabels.append(self.formatter.string(from: dateString!))
					print("Data: \(test["totalScore"]! as! Int), Label: \(self.formatter.string(from: dateString!))")
				} else if test["shortTestName"] as? String == "PHQ9" {
					self.formatter.dateFormat = "MM-dd-yyyy hh:mm a"
					let dateString = self.formatter.date(from: test["testTime"]! as! String)
					self.formatter.dateFormat = "MM/dd"
					PHQ9Data.append(test["totalScore"]! as! Double)
					PHQ9Labels.append(self.formatter.string(from: dateString!))
					print("Data: \(test["totalScore"]! as! Int), Label: \(self.formatter.string(from: dateString!))")
				} else if test["shortTestName"] as? String == "BDC" {
					self.formatter.dateFormat = "MM-dd-yyyy hh:mm a"
					let dateString = self.formatter.date(from: test["testTime"]! as! String)
					self.formatter.dateFormat = "MM/dd"
					BDCData.append(test["totalScore"]! as! Double)
					BDCLabels.append(self.formatter.string(from: dateString!))
					print("Data: \(test["totalScore"]! as! Int), Label: \(self.formatter.string(from: dateString!))")
				}
			}
			completion(GDSData, PHQ9Data, BDCData, GDSLabels, PHQ9Labels, BDCLabels)
		})
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		//		setupScalaceViews()
	}
	
}
