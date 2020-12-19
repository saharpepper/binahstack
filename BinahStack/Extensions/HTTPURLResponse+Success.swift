//
//  HTTPURLResponse+Success.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

extension HTTPURLResponse {
    var isSuccess: Bool {
        return statusCode>=200 && statusCode <= 299
    }
}
