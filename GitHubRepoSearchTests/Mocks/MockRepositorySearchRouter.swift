//
//  MockRepositorySearchRouter.swift
//  GitHubRepoSearchTests
//
//  Created by Michał Warchał on 31/01/2022.
//

import Foundation
@testable import GitHubRepoSearch

class MockRepositorySearchRouter: RepositorySearchRouter {
    
    private(set) var urlToOpen: URL?
    func openURL(_ url: URL) {
        urlToOpen = url
    }
    
    private(set) var errorToShow: Error?
    func showError(_ error: Error) {
        errorToShow = error
    }
}
