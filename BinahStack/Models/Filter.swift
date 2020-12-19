//
//  Filter.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

enum Filter {
    case answered
    case unAnswered
    func inverted() -> Self {
        return self == .answered ? .unAnswered : .answered
    }
}
