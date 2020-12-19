//
//  MockSource.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

class MockSource: Source {
    // MARK: - Constants
    struct Constants {
        static let mockNumberOfQuestionsPerPage = 10
        static let mockNumberOfPages = 3
    }
    
    // MARK: - Props
    weak var delegate: SourceDelegate?

    // MARK: - Accessors
    func getQuestions(filter: Filter, page: Int) {
        var questions = [Question]()
        for i in 1...Constants.mockNumberOfQuestionsPerPage {
            let questionPrefix = filter == .answered ? "Answered" : "UnAnswered"
            let question = Question(answers: page, votes: i, title: "\(questionPrefix)\(i)", tags: ["tag\(i)"], user: "user\(i)", creationDate: Date().timeIntervalSinceNow, link: "https://www.google.com")
            questions.append(question)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didReceive(questions: questions,
                                       filter: filter,
                                       page: page,
                                       total: Constants.mockNumberOfPages*Constants.mockNumberOfQuestionsPerPage)
        }
    }
}
