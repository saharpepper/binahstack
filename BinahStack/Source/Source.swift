//
//  Source.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

protocol SourceDelegate: class {
    func didReceive(questions: [Question], filter: Filter, page: Int, total: Int)
    func didFail(error: Error?)
}

protocol Source {
    var delegate: SourceDelegate? { get set }
    func getQuestions(filter: Filter, page: Int)
}
