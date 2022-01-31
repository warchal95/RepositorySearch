//
//  GitHubRepositoryService.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 30/01/2022.
//

import Foundation

protocol GitHubRepositoryService {
    func get(query: String, completion: @escaping (Result<[GitHubRepository], Error>) -> Void)
}

class NetworkBasedGithubRepositoryService: GitHubRepositoryService {
    
    func get(query: String, completion: @escaping (Result<[GitHubRepository], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "https://api.github.com/search/repositories") else {
            completion(.failure(NetworkError.requestMalformed))
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "per_page", value: "20")
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.requestMalformed))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                200 ..< 300 ~= response.statusCode,
                error == nil
            else {
                completion(.failure(error ?? NetworkError.general))
                return
            }
            if let gitHubRepositoryResponse = try? JSONDecoder().decode(GitHubRepositoryResponse.self, from: data) {
                completion(.success(gitHubRepositoryResponse.items))
            } else {
                completion(.failure(NetworkError.parsing))
            }
        }
        task.resume()
    }
}
