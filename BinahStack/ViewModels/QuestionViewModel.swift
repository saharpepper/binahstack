//
//  QuestionViewModel.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

class QuestionViewModel {
    
    // MARK: - Props
    private let question: Question!
    
    // MARK: - Lifecycle
    init(question: Question) {
        self.question = question
    }
    
    // MARK: - Accessors
    var answersCount: String {
        return String(question.answers)
    }
    
    var votesCount: String {
        return String(question.votes)
    }
    
    var title: String {
        return question.title
    }
    
    var tags: [String] {
        return question.tags
    }
    
    var creationText: String {
        return "Created by \(question.user)"
    }
}
