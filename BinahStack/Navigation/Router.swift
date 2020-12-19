//
//  Router.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import UIKit

protocol Router: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
