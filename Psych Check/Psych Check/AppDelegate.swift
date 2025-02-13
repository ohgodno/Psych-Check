//  AppDelegate.swift
//  Psych Check
//
//  Copyright © 2017 Harrison Crandall. All rights reserved.

import UIKit
import Foundation
import UserNotifications

import Firebase
import FirebaseAuth
import FirebaseInstanceID
import FirebaseMessaging
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
	
	var window: UIWindow?
	let gcmMessageIDKey = "gcm.message_id"
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		FIRApp.configure()
		
		FIRDatabase.database().persistenceEnabled = true
		
		GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
		GIDSignIn.sharedInstance().delegate = self
		
		if #available(iOS 10.0, *) {
			// For iOS 10 display notification (sent via APNS)
//			UNUserNotificationCenter.current().delegate = self
			
			let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
			UNUserNotificationCenter.current().requestAuthorization(
				options: authOptions,
				completionHandler: {_, _ in })
			
			// For iOS 10 data message (sent via FCM)
//			FIRMessaging.messaging().remoteMessageDelegate = self
			
		} else {
			let settings: UIUserNotificationSettings =
				UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
			application.registerUserNotificationSettings(settings)
		}
		
		application.registerForRemoteNotifications()
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
		print("DEVICE TOKEN = \(token)")
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		print(error)
	}
	
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		print(userInfo)
		if let messageID = userInfo[gcmMessageIDKey] {
			print("Message ID: \(messageID)")
		}
		print("🙌🙌🙌 NOTIFICATION REVEIVED 🙌🙌🙌")
		
		completionHandler(UIBackgroundFetchResult.newData)

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
		guard let controller = GIDSignIn.sharedInstance().uiDelegate as? PickSignInViewController else { return }
		
		if let error = error {
			print("\(error.localizedDescription) (AppDelegate/didSignInFor)")
			if error.localizedDescription == "The user canceled the sign-in flow." {
				controller.googleSignInButton.setOriginalState()
			}
			
			NotificationCenter.default.post(
				name: Notification.Name(rawValue: "AuthUINotification"), object: nil, userInfo: nil)
		} else {
			print("🎉🎉🎉 CONNECTED 🎉🎉🎉")
			NotificationCenter.default.post(
				name: Notification.Name(rawValue: "AuthUINotification"),
				object: nil,
				userInfo: ["statusText": "Signed in user:\n\(user.profile.name!)"])
			
			guard let authentication = user.authentication else { return }
			let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
			                                                  accessToken: authentication.accessToken)
			controller.firebaseLogin(credential)
		}
	}
	
	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
	          withError error: Error!) {
		print("🔴🔴🔴 DISCONNECTED 🔴🔴🔴")
		// Perform any operations when the user disconnects from app here.
		// [START_EXCLUDE]
		NotificationCenter.default.post(
			name: Notification.Name(rawValue: "AuthUINotification"),
			object: nil,
			userInfo: ["statusText": "User has disconnected."])
		// [END_EXCLUDE]
	}
	
	
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

