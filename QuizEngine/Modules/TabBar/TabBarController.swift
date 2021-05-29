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
        let create = UINavigationController(rootViewController: CreateQuizController(quiz: Quiz()))
        create.tabBarItem.image = Assets.tabBarIconAdd.image
        create.tabBarItem.title = Text.EditQuiz.tabBarTitle
        let quizList = UINavigationController(rootViewController: QuizListController())
        quizList.tabBarItem.image = Assets.tabBarIconQuizList.image
        quizList.tabBarItem.title = Text.QuizList.title
        let profile = UINavigationController(rootViewController: ProfileController())
        profile.tabBarItem.image = Assets.tabBarIconProfile.image
        profile.tabBarItem.title = Text.Profile.title
        viewControllers = [create, quizList, profile]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
