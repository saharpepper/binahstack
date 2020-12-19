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
    private let filterBtn = UIButton(type: .system)
    
    // MARK: - Lifecycle
    init(title: String, filter: Filter, btnAction: @escaping (Filter)->()) {
        self.filter = filter
        self.btnAction = btnAction
        super.init(title: title)
        filterBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        filterBtn.addTarget(self, action: #selector(filterBtnClicked), for: .touchUpInside)
        let navFilterBtn = UIBarButtonItem(customView: filterBtn)
        rightBarButtonItem = navFilterBtn
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Accessors
    private func setTitle(filter: Filter) {
        filterBtn.setTitle(navTitle(filter: filter), for: .normal)
        filterBtn.sizeToFit()
    }
    
    // MARK: - Actions
    @objc private func filterBtnClicked() {
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

