//
//  ParticipantController.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import MDFoundation

protocol ParticipantControllerLogic: AnyObject {
    func presentParticipant(_ entity: ParticipantResults)
    func presentError(message: String)
}

class ParticipantController: UIViewController, ParticipantControllerLogic {
    // MARK: - Properties

    lazy var customView = ParticipantView()
    var interactor: ParticipantInteractor?

    let generator = UINotificationFeedbackGenerator()

    let quizId: String
    let participantId: Int

    // MARK: - Init

    init(quizId: String, participantId: Int) {
        self.quizId = quizId
        self.participantId = participantId
        super.init(nibName: nil, bundle: nil)
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
        setup()
        setupAppearance()
        loadParticipant()
    }

    private func setup() {
        interactor = ParticipantInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.ParticipantResults.title
        customView.setDelegate(self)
    }

    // MARK: - Network requests

    private func loadParticipant() {
        customView.showLoading()
        interactor?.loadParticipantResults(quizId: quizId, participantId: participantId)
    }

    // MARK: - ParticipantControllerLogic

    func presentParticipant(_ entity: ParticipantResults) {
        customView.updateAppearance(with: entity)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - ParticipantCellSetupDelegate

extension ParticipantController: ParticipantCellSetupDelegate {
    func reloadAction() {
        loadParticipant()
    }
}
