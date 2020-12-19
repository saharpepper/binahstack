//
//  NetworkSource.swift
//  BinahStack
//
//  Created by Sahar Radomsky on 19/12/2020.
//

import Foundation

class NetworkSource: Source {
    // MARK: - Constants
    private struct Constants {
        static let baseUrl = "https://api.stackexchange.com/2.2/search/advanced"
    }
    
    // MARK: - Props
    weak var delegate: SourceDelegate?
    private let session = URLSession(configuration: .default)
    
    // MARK: - Accessors
    func getQuestions(filter: Filter, page: Int) {
        var components = URLComponents(string: Constants.baseUrl)!
        components.queryItems = parameters(filter: filter, page: page).map { (k, v) in URLQueryItem(name: k, value: v) }
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.timeoutInterval = 10.0
        session.dataTask(with: urlRequest, completionHandler: { [weak self] (data, response, error) in
            
            guard let response = response as? HTTPURLResponse, response.isSuccess, let data = data else {
                DispatchQueue.main.async {
                    self?.delegate?.didFail(error: error)
                }
                return
            }
            
            guard let questionsResponse = try? JSONDecoder().decode(QuestionsResponse.self, from: data) else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Corrupted data"])
                DispatchQueue.main.async {
                    self?.delegate?.didFail(error: error)
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.delegate?.didReceive(questions: questionsResponse.items,
                                           filter: filter,
                                           page: questionsResponse.page,
                                           total: questionsResponse.total)
            }
        }).resume()
    }
    
    // MARK: - Helpers
    private func parameters(filter: Filter, page: Int) -> [String: String] {
        return ["order": "desc",
                "sort": "activity",
                "site": "stackoverflow",
                "filter": "!--1nZxv_nzwE",
                "page": "\(page)",
                "pagesize": "30",
                "accepted": String(filter == .answered)
                ]
    }
}
