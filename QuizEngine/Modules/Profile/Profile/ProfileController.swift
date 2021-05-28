//
//  ProfileController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

protocol ProfileControllerLogic: AnyObject {
    func didFinishLoadingProfile(_ response: Profile)
    func presentError(message: String)
}

class ProfileController: UIViewController, ProfileControllerLogic {
    // MARK: - Properties

    var interactor: ProfileInteractor?

    lazy var customView: ProfileView? = view as? ProfileView

    // MARK: - Init

    init() {
        super.init(
            nibName: Utils.getClassName(ProfileView.self),
            bundle: resourcesBundle
        )
        setup()
        setupAppearance()
        addActionHandlers()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        interactor = ProfileInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        tabBarItem.image = Assets.tabBarIconProfile.image
        title = Text.Profile.title
    }

    // MARK: - Life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    // MARK: - Networking

    private func loadData() {
        customView?.startShowingActivityIndicator(needToDimBackground: true)
        interactor?.loadProfile()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {}

    // MARK: - ProfileControllerLogic

    func didFinishLoadingProfile(_ response: Profile) {
        customView?.stopShowingActivityIndicator()
        customView?.displayProfile(response)
    }

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
