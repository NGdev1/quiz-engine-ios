//
//  CreateQuizController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

protocol CreateQuizControllerLogic: AnyObject {
    func presentQuiz(_ entity: Quiz)
    func presentError(message: String)
}

class CreateQuizController: UIViewController, CreateQuizControllerLogic {
    // MARK: - Properties

    lazy var customView = CreateQuizView()
    var interactor: CreateQuizInteractor?

    let generator = UINotificationFeedbackGenerator()

    // MARK: - Life cycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAppearance()
    }

    private func setup() {
        interactor = CreateQuizInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.CreateQuiz.title
        customView.setDelegate(self)
    }

    // MARK: - Network requests

    // MARK: - CreateQuizControllerLogic

    func presentQuiz(_ entity: Quiz) {
        customView.updateAppearance(with: entity)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - CreateQuizCellSetupDelegate

extension CreateQuizController: CreateQuizCellSetupDelegate {
    func reloadAction() {}
}
