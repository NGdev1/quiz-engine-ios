//
//  ProfileController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation
import Storable

protocol ProfileControllerLogic: AnyObject {
    func presentProfile(_ entity: Profile)
    func presentError(message: String)
}

class ProfileController: UIViewController, ProfileControllerLogic {
    // MARK: - Properties

    lazy var customView = ProfileView()
    var interactor: ProfileInteractor?

    let generator = UINotificationFeedbackGenerator()

    // MARK: - Life cycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAppearance()
        loadProfile()
        addActionHandlers()
    }

    private func setup() {
        interactor = ProfileInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.Profile.title
        customView.setDelegate(self)
    }

    // MARK: - Network requests

    private func loadProfile() {
        customView.showLoading()
        interactor?.loadProfile()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Text.Profile.logOut, style: .plain,
            target: self, action: #selector(logOut)
        )
    }

    @objc
    private func logOut() {
        AppService.shared.app.accessToken = nil
        view.window?.rootViewController = UINavigationController(rootViewController: OnboardingController())
    }

    // MARK: - ProfileControllerLogic

    func presentProfile(_ entity: Profile) {
        customView.updateAppearance(with: entity)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - ProfileCellSetupDelegate

extension ProfileController: ProfileCellSetupDelegate {
    func editProfile() {}

    func reloadAction() {
        loadProfile()
    }
}
