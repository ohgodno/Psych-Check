//  DigitalCatnipExtensions.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

//  Sorry james mccarthy I completely ripped off ur thing
//  but thx, i think itll be useful


import Foundation
import UIKit


extension Dictionary {
	//  Build string representation of HTTP parameter dictionary of keys and objects
	
	func stringFromHttpParameters() -> String {
		let parameterArray = self.map { (key, value) -> String in
			let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
			let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
			return "\(percentEscapedKey)=\(percentEscapedValue)"
		}
		
		return parameterArray.joined(separator: "&")
	}
}

extension String {
	//  This percent-escapes all characters besize the alphanumeric character set and "-", ".", "_", and "~".
	
	func stringByAddingPercentEncodingForURLQueryValue() -> String? {
		let characterSet = NSMutableCharacterSet.alphanumeric()
		characterSet.addCharacters(in: "-._~")
		
		return self.addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)
	}
}

extension UIViewController {
	func showAlert(title : String, message: String, sourceVC: UIViewController) {
		let alert = UIAlertController(
			title: title,
			message: message,
			preferredStyle: UIAlertControllerStyle.alert
		)
		let ok = UIAlertAction(
			title: "OK",
			style: UIAlertActionStyle.default,
			handler: nil
		)
		alert.addAction(ok)
		sourceVC.present(alert, animated: true, completion: nil)
	}
}
