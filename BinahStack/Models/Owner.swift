//
//  Owner.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

struct Owner: Decodable {
    var reputation: Int?
    var userId: Int?
    var userType: String?
    var profileImage: String?
    var displayName: String
    var link: String?

    enum CodingKeys: String, CodingKey {
        case reputation
        case userId = "user_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
    
    init(user: String) {
        self.displayName = user
    }
}
