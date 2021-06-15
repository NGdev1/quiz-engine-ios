//
//  SelectRegionController.swift
//  QuizEngine
//
//  Created by Admin on 14.06.2021.
//

import Map
import MDFoundation

class SelectRegionController: UIViewController {
    // MARK: - Properties

    lazy var customView = SelectRegionView()
    private var isInitialLocationRequest: Bool = true

    let quizId: String?
    let editQuizController: EditQuestionControllerDelegate

    // MARK: - Init

    init(quizId: String?, editQuizController: EditQuestionControllerDelegate) {
        self.quizId = quizId
        self.editQuizController = editQuizController
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
        setupAppearance()
        addActionHandlers()
    }

    private func setupAppearance() {
        title = Text.SelectRegion.title
        LocationManager.sharedInstance.updateLocation()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        LocationManager.sharedInstance.delegate = self
        customView.userLocationButton.addTarget(
            self,
            action: #selector(moveCameraToUserLocationButtonTapped),
            for: .touchUpInside
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Text.SelectRegion.search, style: .plain,
            target: self, action: #selector(searchAction)
        )
    }

    @objc
    private func searchAction() {
        navigationController?.pushViewController(
            SelectEntityController(
                method: .map(region: customView.mapView.region), quizId: quizId,
                editQuizController: editQuizController, graphType: .dbpedia
            )
        )
    }

    @objc private func moveCameraToUserLocationButtonTapped() {
        LocationManager.sharedInstance.updateLocation()
    }
}

// MARK: - LocationManagerDelegate

extension SelectRegionController: LocationManagerDelegate {
    func userLocationUpdated(_ location: Location) {
        customView.mapView.moveCameraTo(
            location: location,
            animated: isInitialLocationRequest == false,
            defaultScale: false
        )
        isInitialLocationRequest = false
    }

    func userAsksLocationButDidNotAllow() {
        let alert = AlertsFactory.accessDeniedWithSettingsLink(
            title: Text.Alert.error,
            message: Text.Errors.userLocationDenied,
            openSettingsText: Text.Errors.openSettingsAction,
            tintColor: Assets.baseTint1.color,
            cancelText: Text.Common.cancel
        )
        present(alert, animated: true, completion: nil)
    }
}
