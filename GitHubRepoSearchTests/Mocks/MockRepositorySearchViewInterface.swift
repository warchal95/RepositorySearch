//
//  MockRepositorySearchViewInterface.swift
//  GitHubRepoSearchTests
//
//  Created by Michał Warchał on 31/01/2022.
//

import Foundation
@testable import GitHubRepoSearch

class MockRepositorySearchViewInterface: RepositorySearchViewInterface {
    var isUserInteractionEnabled: Bool = true
    
    var wasUpdateDataSourceCalled = false
    func updateDataSource() {
        wasUpdateDataSourceCalled = true
    }
}
