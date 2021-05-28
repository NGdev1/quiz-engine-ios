//
//  QuizListController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

protocol QuizListControllerLogic: AnyObject {
    func displayList(response: [Quiz])
    func presentError(message: String)
}

class QuizListController: UIViewController, QuizListControllerLogic {
    // MARK: - Properties

    var interactor: QuizListInteractor?

    lazy var customView = QuizListView()
    lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    // MARK: - Init

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        setupAppearance()
        addActionHandlers()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizList()
    }

    private func setup() {
        interactor = QuizListInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        tabBarItem.image = Assets.tabBarIconQuizList.image
        title = Text.QuizList.title
        extendedLayoutIncludesOpaqueBars = true
    }

    // MARK: - Network requests

    @objc
    private func loadQuizList() {
        interactor?.loadList()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView.refreshControl?.addTarget(
            self,
            action: #selector(loadQuizList),
            for: .valueChanged
        )
        customView.setDelegate(self)
    }

    // MARK: - QuizListControllerLogic

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

extension QuizListController: QuizDataSourceDelegate {
    func didSelectQuiz(_ item: Quiz) {
        // router?.trigger(.openItem(delegate: self, item: item))
    }

    func actionButtonTapped() {
        customView.showLoading()
        loadQuizList()
    }
}
