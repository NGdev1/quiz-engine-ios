//
//  MainController.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

import MDFoundation

protocol MainControllerLogic: AnyObject {
    func displayList(response: [Quiz])
    func presentError(message: String)
}

class MainController: UIViewController, MainControllerLogic {
    // MARK: - Properties

    var interactor: MainInteractor?

    lazy var customView = MainView()
    lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    // MARK: - Life cycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAppearance()
        addActionHandlers()
        loadQuizs()
    }

    private func setup() {
        interactor = MainInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        title = Text.Main.title
        extendedLayoutIncludesOpaqueBars = true
    }

    // MARK: - Network requests

    @objc
    private func loadQuizs() {
        interactor?.loadList()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView.refreshControl?.addTarget(
            self,
            action: #selector(loadQuizs),
            for: .valueChanged
        )
        customView.setDelegate(self)
    }

    // MARK: - MainControllerLogic

    func displayList(response: [Quiz]) {
        customView.endRefreshing()
        customView.updateQuizs(response)
    }

    func presentError(message: String) {
        customView.endRefreshing()
        notificationFeedbackGenerator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - QuizsDataSourceDelegate

extension MainController: HomePageDataSourceDelegate {
    func didSelectQuiz(_ item: Quiz) {
        // router?.trigger(.openItem(delegate: self, item: item))
    }

    func actionButtonTapped() {
        customView.showLoading()
        loadQuizs()
    }
}
