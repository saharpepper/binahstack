//
//  AutoRefreshController.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation
import UIKit

@objc protocol AutoRefreshControllerDelegate {
    func shouldRefresh()
    @objc optional func didSkipRefresh()
}

class AutoRefreshController {
    // MARK: - Props
    private weak var delegate: AutoRefreshControllerDelegate?
    private var lastSuccess: Date?
    private var threshold: TimeInterval
    
    // MARK: - Accessors
    func markSuccess() {
        lastSuccess = Date()
    }
    
    // MARK: - Lifecycle
    init(delegate: AutoRefreshControllerDelegate, thresholdInSeconds threshold: TimeInterval) {
        self.delegate = delegate
        self.threshold = threshold
        setupMonitor()
    }
    
    // MARK: - Setup
    private func setupMonitor() {
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { [weak self] _ in
            guard let lastSuccess = self?.lastSuccess, let threshold = self?.threshold else {
                self?.delegate?.didSkipRefresh?()
                return
            }
            let now = Date()
            let secondsPassed = now.timeIntervalSinceReferenceDate - lastSuccess.timeIntervalSinceReferenceDate
            if secondsPassed > threshold {
                self?.delegate?.shouldRefresh()
            } else {
                self?.delegate?.didSkipRefresh?()
            }
        }
    }
}
