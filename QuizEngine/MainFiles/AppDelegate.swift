//
//  AppDelegate.swift
//  QuizEngine
//
//  Created by Михаил Андреичев on 12.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window?.rootViewController = OnboardingController()
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: - App life cycle

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}
}
