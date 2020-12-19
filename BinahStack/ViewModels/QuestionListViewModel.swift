//
//  QuestionListViewModel.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

protocol QuestionListViewModelDelegate: class {
    func loadSuccess(newIndexPaths: [IndexPath]?, filter: Filter)
    func loadFailed(error: Error?)
}

class QuestionListViewModel {
    // MARK: - Props
    weak var delegate: QuestionListViewModelDelegate?
    private var fetchInProgress = false
    private var source: Source!
    private var currentPage = 1
    private var total = 0
    private var questions = [QuestionViewModel]()
    private var maxCount = 300
    
    // MARK: - Setup
    init(source: Source) {
        self.source = source
        self.source.delegate = self
    }
    
    // MARK: - Accessors
    func questionAt(index: Int) -> QuestionViewModel {
        return questions[index]
    }
    
    var totalCount: Int {
        return total > maxCount ? maxCount : total
    }
    
    var currentCount: Int {
        return questions.count
    }
    
    func loadData(filter: Filter) {
        guard !fetchInProgress else { return }
        fetchInProgress = true
        source.getQuestions(filter: filter, page: currentPage)
    }
    
    func clearData() {
        currentPage = 1
        total = 0
        questions.removeAll()
    }
    
    // MARK: - Helpers
    private func reloadIndexPaths(newItemsCount: Int) -> [IndexPath] {
      let startIndex = questions.count - newItemsCount
      let endIndex = startIndex + newItemsCount
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

extension QuestionListViewModel: SourceDelegate {
    func didReceive(questions: [Question], filter: Filter, page: Int, total: Int) {
        currentPage += 1
        fetchInProgress = false
        if self.total == 0 {
            self.total = total
        }
        self.questions.append(contentsOf: questions.map { QuestionViewModel(question: $0) })
        
        if page > 1 {
            let newIndexPaths = reloadIndexPaths(newItemsCount: questions.count)
            delegate?.loadSuccess(newIndexPaths: newIndexPaths, filter: filter)
        } else {
            delegate?.loadSuccess(newIndexPaths: .none, filter: filter)
        }
    }
    
    func didFail(error: Error?) {
        fetchInProgress = false
        delegate?.loadFailed(error: error)
    }
}
