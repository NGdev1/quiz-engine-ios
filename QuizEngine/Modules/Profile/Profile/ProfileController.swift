//
//  ProfileController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

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
    }

    private func setup() {
        interactor = ProfileInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.Profile.title
        customView.tableBuilder?.delegate = self
    }

    // MARK: - Network requests

    private func loadProfile() {
        customView.showLoading()
        interactor?.loadProfile()
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
    func reloadAction() {
        loadProfile()
    }
}
