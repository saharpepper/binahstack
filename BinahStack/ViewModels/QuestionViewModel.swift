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
        return String(question.answerCount)
    }
    
    var votesCount: String {
        return String(question.score)
    }
    
    var title: String {
        return question.title
    }
    
    var tags: [String] {
        return question.tags
    }
    
    var relativeCreationText: String {
        let creationDate = Date(timeIntervalSince1970: question.creationDate)
        return "Created \(creationDate.friendlyTimeAgo()) by \(question.owner.displayName)"
    }
    
    var link: String {
        return question.link
    }
}
