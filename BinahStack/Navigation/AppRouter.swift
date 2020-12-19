//
//  AppRouter.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import UIKit

class AppRouter: Router {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        #if DEBUG
        let source: Source = isTestMode ? MockSource() : NetworkSource()
        #else
        let source = NetworkSource()
        #endif
        let feedTableViewController = FeedTableViewController(router: self, source: source)
        navigationController.pushViewController(feedTableViewController, animated: false)
    }
    
    func details(question: QuestionViewModel) {
        let questionDetailsViewController = QuestionDetailsViewController(question: question)
        navigationController.pushViewController(questionDetailsViewController, animated: true)
    }
    
    #if DEBUG
    private var isTestMode: Bool {
        let arguments = ProcessInfo.processInfo.arguments
        return arguments.contains("UI_TESTING")
    }
    #endif
}
