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
        let questionsTableViewController = ViewController()
        navigationController.pushViewController(questionsTableViewController, animated: false)
    }
}
