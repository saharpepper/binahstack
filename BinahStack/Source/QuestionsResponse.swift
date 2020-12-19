//
//  QuestionsResponse.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

struct QuestionsResponse: Decodable {
    var items: [Question]
    var hasMore: Bool
    var quotaMax: Int
    var quotaRemaining: Int
    var total: Int
    var page: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
        case total
        case page
    }
}
