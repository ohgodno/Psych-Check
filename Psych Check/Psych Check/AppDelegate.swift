//  AppDelegate.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
	
	var window: UIWindow?
	
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		FIRApp.configure()
		
		GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
		GIDSignIn.sharedInstance().delegate = self
		return true
	}
	
	@available(iOS 9.0, *)
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
		return GIDSignIn.sharedInstance().handle(url,
		                                         sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
		                                         annotation: options[UIApplicationOpenURLOptionsKey.annotation])
	}
	
	func application(_ application: UIApplication,
	                 open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		return GIDSignIn.sharedInstance().handle(url,
		                                         sourceApplication: sourceApplication,
		                                         annotation: annotation)
	}
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
	          withError error: Error!) {
		if let error = error {
			print("\(error.localizedDescription)")
			NotificationCenter.default.post(
				name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
		} else {
			// Perform any operations on signed in user here.
//			let userId = user.userID                  // For client-side use only!
//			let idToken = user.authentication.idToken // Safe to send to the server
			let fullName = user.profile.name
//			let givenName = user.profile.givenName
//			let familyName = user.profile.familyName
//			let email = user.profile.email
			defaultsUser.set(["userID":user.userID,
			                  "IDToken":user.authentication.idToken,
			                  "fullName":user.profile.name,
			                  "givenName":user.profile.givenName,
			                  "familyName":user.profile.familyName,
			                  "email":user.profile.email], forKey: "userDict")
			NotificationCenter.default.post(
				name: Notification.Name(rawValue: "ToggleAuthUINotification"),
				object: nil,
				userInfo: ["statusText": "Signed in user:\n\(fullName!)"])
		}
	}
	
	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
	          withError error: Error!) {
		// Perform any operations when the user disconnects from app here.
		// [START_EXCLUDE]
		NotificationCenter.default.post(
			name: Notification.Name(rawValue: "ToggleAuthUINotification"),
			object: nil,
			userInfo: ["statusText": "User has disconnected."])
		// [END_EXCLUDE]
	}
	
	
	
//	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//
//  if let error = error { return }
//		
//  guard let authentication = user.authentication else { return }
//  let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//  FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//		if let error = error { return }
//		}
//	}
//	
//	func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
//	            withError error: NSError!) {
//		if (error == nil) {
//			// Perform any operations on signed in user here.
//			//			let userId = user.userID										// For client-side use only!
//			//			let idToken = user.authentication.idToken		// Safe to send to the server
//			//			let fullName = user.profile.name
//			//			let givenName = user.profile.givenName
//			//			let familyName = user.profile.familyName
//			//			let email = user.profile.email
//			print("User ID: \(user.userID)")
//			print("ID Token: \(user.authentication.idToken)")
//			print("Full Name: \(user.profile.name)")
//			print("Given Name: \(user.profile.givenName)")
//			print("Family Name: \(user.profile.familyName)")
//			print("Email: \(user.profile.email)")
//		} else {
//			print("\(error.localizedDescription)")
//		}
//	}
	
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
}

