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
        static let initialFilter = Filter.answered
        static let title = "BinahStack"
        static let cellId = NSStringFromClass(FeedTableViewCell.classForCoder()).components(separatedBy: ".").last!
    }
    
    // MARK: - Props
    private weak var router: AppRouter?
    private let questionListViewModel: QuestionListViewModel!
    private lazy var feedTableNavigationItem = {
        return FeedTableNavigationItem(title: Constants.title, filter: Constants.initialFilter) { [weak self] filter in
            self?.resetData()
            self?.loadData(filter: filter)
        }
    }()
    
    // MARK: - Lifecycle
    init(router: AppRouter) {
        self.router = router
        questionListViewModel = QuestionListViewModel(source: MockSource())
        super.init(nibName: nil, bundle: nil)
        questionListViewModel.delegate = self
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(filter: activeFilter)
    }
    
    // MARK: - Setup
    private var activeFilter: Filter {
        get {
            return feedTableNavigationItem.filter
        }
        set {
            feedTableNavigationItem.filter = newValue
        }
    }
    
    private func resetData() {
        questionListViewModel.clearData()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.prefetchDataSource = self
        tableView.separatorInset = .zero
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: Constants.cellId, bundle: .main), forCellReuseIdentifier: Constants.cellId)
    }
    
    override var navigationItem: UINavigationItem {
        return feedTableNavigationItem
    }
    
    // MARK: - Helpers
    private func loadData(filter: Filter) {
        questionListViewModel.loadData(filter: filter)
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= questionListViewModel.currentCount
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionListViewModel.totalCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingCell(for: indexPath) {
            return UITableViewCell()
        }
        else if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as? FeedTableViewCell {
            let question = questionListViewModel.questionAt(index: indexPath.row)
            cell.question = question
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension FeedTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            loadData(filter: activeFilter)
        }
    }
}

extension FeedTableViewController: QuestionListViewModelDelegate {
    func loadSuccess(newIndexPaths: [IndexPath]?, filter: Filter) {
        guard let newIndexPaths = newIndexPaths else {
            activeFilter = filter
            tableView.reloadData()
            return
        }
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(newIndexPaths)
        tableView.reloadRows(at: Array(indexPathsIntersection), with: .automatic)
    }
    
    func loadFailed(error: Error?) {
    }
}
