//
//  FeedTableViewController.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import UIKit

class FeedTableViewController: UITableViewController {
    // MARK: - Constants
    private struct Constants {
        static let cellId = NSStringFromClass(FeedTableViewCell.classForCoder()).components(separatedBy: ".").last!
    }
    
    // MARK: - Props
    private var data = [QuestionViewModel]()
    
    // MARK: - Lifecycle
    init(router: AppRouter) {
        super.init(nibName: nil, bundle: nil)
        let question = Question(answers: 2, votes: 1, title: "My question?", tags: ["tag1", "tag2", "tag3"], user: "User")
        let questionViewModel = QuestionViewModel(question: question)
        data.append(questionViewModel)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        tableView.separatorInset = .zero
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: Constants.cellId, bundle: .main), forCellReuseIdentifier: Constants.cellId)
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as? FeedTableViewCell {
            cell.question = data[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
