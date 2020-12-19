//
//  UIView+Loading.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import UIKit

extension UIView {
    func addLoader() {
        removeLoader()
        let indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            indicator.style = .gray
        }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor).isActive = true
    }
    
    func removeLoader() {
        subviews.forEach {
            if let activityIndicatorView = $0 as? UIActivityIndicatorView {
                activityIndicatorView.removeFromSuperview()
            }
        }
    }
}
