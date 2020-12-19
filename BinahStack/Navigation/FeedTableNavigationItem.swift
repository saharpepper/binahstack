//
//  FeedTableNavigationItem.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import UIKit

class FeedTableNavigationItem: UINavigationItem {
    // MARK: - Constants
    private struct Constants {
        static let answeredTitle = "Answered"
        static let unAnsweredTitle = "UnAnswered"
    }
    
    // MARK: - Props
    var filter: Filter! {
        didSet {
            setTitle(filter: filter)
        }
    }
    private let btnAction: (Filter)->()?
    
    // MARK: - Lifecycle
    init(title: String, filter: Filter, btnAction: @escaping (Filter)->()) {
        self.filter = filter
        self.btnAction = btnAction
        super.init(title: title)
        let navFilterBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(navFilterBtnClicked))
        let font = UIFont.boldSystemFont(ofSize: 14.0)
        [UIControl.State.normal, UIControl.State.highlighted].forEach {
            navFilterBtn.setTitleTextAttributes([NSAttributedString.Key.font: font], for: $0)
        }
        rightBarButtonItem = navFilterBtn
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Accessors
    private func setTitle(filter: Filter) {
        guard let navFilterBtn = rightBarButtonItem else { return }
        navFilterBtn.title = navTitle(filter: filter)
    }
    
    // MARK: - Actions
    @objc private func navFilterBtnClicked() {
        btnAction(filter.inverted())
    }
    
    // MARK: - Helpers
    private func navTitle(filter: Filter) -> String {
        switch filter {
        case .answered:
            return Constants.answeredTitle
        case .unAnswered:
            return Constants.unAnsweredTitle
        }
    }
}

