//
//  TabBarController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

class TabBarController: UITabBarController {
    static let createTabIndex: Int = 0
    static let quizListTabIndex: Int = 1
    static let profileTabIndex: Int = 2

    init() {
        super.init(nibName: nil, bundle: nil)
        let home = UINavigationController(rootViewController: MainController())
        home.tabBarItem.image = Assets.tabBarIconHome.image
        home.tabBarItem.title = Text.Main.title
        let create = UINavigationController(rootViewController: EditQuizController(quiz: Quiz()))
        create.tabBarItem.image = Assets.tabBarIconAdd.image
        create.tabBarItem.title = Text.EditQuiz.tabBarTitle
        let quizList = UINavigationController(rootViewController: QuizListController())
        quizList.tabBarItem.image = Assets.tabBarIconQuizList.image
        quizList.tabBarItem.title = Text.QuizList.title
        let profile = UINavigationController(rootViewController: ProfileController())
        profile.tabBarItem.image = Assets.tabBarIconProfile.image
        profile.tabBarItem.title = Text.Profile.title
        viewControllers = [home, create, quizList, profile]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
