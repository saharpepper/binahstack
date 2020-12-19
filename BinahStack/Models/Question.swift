//
//  Question.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

struct Question: Decodable {
    var tags: [String]
    var owner: Owner
    var isAnswered: Bool?
    var viewCount: Int?
    var closedDate: TimeInterval?
    var answerCount: Int
    var score: Int
    var lastActivityDate: TimeInterval?
    var creationDate: TimeInterval
    var lastEditDate: TimeInterval?
    var questionId: Int?
    var link: String
    var closedReason: String?
    var title: String

    enum CodingKeys: String, CodingKey {
        case tags
        case owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case closedDate = "closed_date"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case questionId = "question_id"
        case link
        case closedReason = "closed_reason"
        case title
    }
    
    init(answers: Int, votes: Int, title: String, tags: [String], user: String, creationDate: TimeInterval, link: String) {
        self.link = link
        self.creationDate = creationDate
        self.answerCount = answers
        self.score = votes
        self.title = title
        self.tags = tags
        owner = Owner(user: user)
    }
}
