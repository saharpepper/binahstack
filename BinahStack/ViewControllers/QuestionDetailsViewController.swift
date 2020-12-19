//
//  QuestionDetailsViewController.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import UIKit
import WebKit

class QuestionDetailsViewController: UIViewController {
    // MARK: - Constants
    private struct Constants {
        static let generalError = "Unable to open question"
    }
    
    // MARK: - Props
    private var question: QuestionViewModel
    private let webView = WKWebView()
    
    // MARK: - Lifecycle
    init(question: QuestionViewModel) {
        self.question = question
        super.init(nibName: nil, bundle: nil)
        title = question.title
        view.backgroundColor = .white
        setupWebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupWebView() {
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
                                    webView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                    webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                    webView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                    webView.topAnchor.constraint(equalTo: view.topAnchor),
                                    ])
        loadQuestionUrl()
    }
    
    // MARK: - Help
    private func loadQuestionUrl() {
        let request = URLRequest(url: URL(string: question.link)!)
        webView.load(request)
    }
}

extension QuestionDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let errorMessage = error.localizedDescription.isEmpty ? Constants.generalError : error.localizedDescription
        let alert = UIAlertController(title: "Error",
                                      message: errorMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
            self?.loadQuestionUrl()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
    }
}
