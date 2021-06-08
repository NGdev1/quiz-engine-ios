//
//  AppDelegate.swift
//  QuizEngine
//
//  Created by Михаил Андреичев on 12.04.2021.
//

import Storable
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupConfiguration()
        setupRootController()
        return true
    }

    // MARK: - App life cycle

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    // MARK: - Setup

    private func setupRootController() {
        if AppService.shared.app.accessToken == nil {
            let navigationController = UINavigationController(rootViewController: OnboardingController())
            window?.rootViewController = navigationController
        } else {
            let tabBarController = TabBarController()
            window?.rootViewController = tabBarController
        }
        window?.makeKeyAndVisible()
    }

    private func setupConfiguration() {
        // AppService.shared.app.baseURL = URL(string: "http://192.168.1.14:8080")!
        // AppService.shared.app.baseURL = URL(string: "http://10.17.33.131:8080")!
        AppService.shared.app.baseURL = URL(string: "http://192.168.0.186:8080")!
        // AppService.shared.app.baseURL = URL(string: "http://localhost:8080")!
        if let token = AppService.shared.app.accessToken {
            print("Token \(token)")
        }
    }
}
