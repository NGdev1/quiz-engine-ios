//
//  OnboardingController.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import MDFoundation
import UIKit

class OnboardingController: UIViewController {
    // MARK: - Properties

    lazy var customView: OnboardingView? = view as? OnboardingView

    // MARK: - Init

    init() {
        super.init(
            nibName: Utils.getClassName(OnboardingView.self),
            bundle: resourcesBundle
        )
        addActionHandlers()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView?.loginWithEmailButton.addTarget(
            self, action: #selector(loginWithEmail), for: .touchUpInside
        )
    }

    @objc
    private func loginWithEmail() {
        navigationController?.pushViewController(SignInController())
    }

    // MARK: - OnboardingControllerLogic

    func presentError(message: String) {
        customView?.stopShowingActivityIndicator()
        guard message != .empty else { return }
        let alert = AlertsFactory.plain(
            title: Text.Alert.error,
            message: message,
            tintColor: Assets.baseTint1.color,
            cancelText: Text.Alert.cancel
        )
        present(alert, animated: true, completion: nil)
    }
}
