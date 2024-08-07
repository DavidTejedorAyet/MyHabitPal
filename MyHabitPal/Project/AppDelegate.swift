//
//  AppDelegate.swift
//  MyHabitPal
//
//  Created by David Tejedor on 15/7/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    static let shared = AppDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        self.setupNotifications()

        // Initializce MCM
//		MCMReader.shared.start(mcmId: "1908", launchOptions: launchOptions) { configInfo in
//			if let config = configInfo {
//				Log.info("⚙️⚙️⚙️ MCM CONFIG: \(config)")
//			}
//		}
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Log.local("AppDelegate - applicationDidBecomeActive")
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Log.local("AppDelegate - didRegisterForRemoteNotificationsWithDeviceToken")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Log.local("AppDelegate - didRegisterForRemoteNotificationsWithDeviceToken")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Log.local("AppDelegate - applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Log.local("AppDelegate - applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Log.local("AppDelegate - applicationWillEnterForeground")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Log.local("AppDelegate - applicationWillTerminate")
    }
}

// MARK: - Remote Notifications

extension AppDelegate {
    func setupNotifications() {
    }
}
