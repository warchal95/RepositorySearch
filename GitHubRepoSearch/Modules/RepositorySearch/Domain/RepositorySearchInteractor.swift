//
//  RepositorySearchInteractor.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 29/01/2022.
//

import Foundation

protocol RepositorySearchInteractor {
    func searchForRepositories(query: String, completion: @escaping  (Result<[GitHubRepository], Error>) -> Void)
}

class RepositorySearchDefaultInteractor: RepositorySearchInteractor {
    
    private let repositoryService: GitHubRepositoryService
    
    init(repositoryService: GitHubRepositoryService = NetworkBasedGithubRepositoryService()) {
        self.repositoryService = repositoryService
    }
    
    func searchForRepositories(query: String, completion: @escaping  (Result<[GitHubRepository], Error>) -> Void) {
        repositoryService.get(query: query, completion: completion)
    }
}
