//
//  TabBarController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

class TabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        let quizList = UINavigationController(rootViewController: QuizListController())
        let profile = UINavigationController(rootViewController: ProfileController())
        viewControllers = [quizList, profile]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
