//
//  MockGitHubRepositoryService.swift
//  GitHubRepoSearchTests
//
//  Created by Michał Warchał on 31/01/2022.
//

import Foundation
@testable import GitHubRepoSearch

class MockGitHubRepositoryService: GitHubRepositoryService {
    var query = ""
    var result: Result<[GitHubRepository], Error> = .success([])
    var shouldCallCompletion = true
    
    func get(query: String, completion: @escaping (Result<[GitHubRepository], Error>) -> Void) {
        self.query = query
        guard shouldCallCompletion else { return }
        completion(result)
    }
}
