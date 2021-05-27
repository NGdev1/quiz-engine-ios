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
        // if AppService.shared.app.accessToken == nil
        let navigationController = UINavigationController(rootViewController: OnboardingController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func setupConfiguration() {
        AppService.shared.app.baseURL = URL(string: "http://192.168.1.14:8080")!
        print("Token \(AppService.shared.app.accessToken ?? "")")
    }
}
