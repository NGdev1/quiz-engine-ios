//
//  HistoryController.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

import MDFoundation

protocol HistoryControllerLogic: AnyObject {
    func displayList(response: [QuizPassing])
    func presentError(message: String)
}

class HistoryController: UIViewController, HistoryControllerLogic {
    // MARK: - Properties

    var interactor: HistoryInteractor?

    lazy var customView = HistoryView()
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
        loadQuizPassings()
    }

    private func setup() {
        interactor = HistoryInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        title = Text.History.title
        extendedLayoutIncludesOpaqueBars = true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Network requests

    @objc
    private func loadQuizPassings() {
        interactor?.loadList()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView.refreshControl?.addTarget(
            self,
            action: #selector(loadQuizPassings),
            for: .valueChanged
        )
        customView.setDelegate(self)
        NotificationCenter.default.addObserver(
            self, selector: #selector(userPassedQuiz(notification:)),
            name: .userFinishedQuiz, object: nil
        )
    }

    @objc
    private func userPassedQuiz(notification: NSNotification) {
        customView.showLoading()
        loadQuizPassings()
    }

    // MARK: - HistoryControllerLogic

    func displayList(response: [QuizPassing]) {
        customView.endRefreshing()
        customView.updateQuizPassings(response)
    }

    func presentError(message: String) {
        customView.endRefreshing()
        notificationFeedbackGenerator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - QuizPassingsDataSourceDelegate

extension HistoryController: HistoryDataSourceDelegate {
    func didSelectQuizPassing(_ item: QuizPassing) {
        guard let quizId = item.quiz?.id else { return }
        navigationController?.pushViewController(QuizResultController(quizId: quizId, passingId: item.id))
    }

    func actionButtonTapped() {
        customView.showLoading()
        loadQuizPassings()
    }
}
