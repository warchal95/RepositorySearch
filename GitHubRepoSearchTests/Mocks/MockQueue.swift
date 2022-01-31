//
//  MockQueue.swift
//  GitHubRepoSearchTests
//
//  Created by Michał Warchał on 31/01/2022.
//

import Foundation
@testable import GitHubRepoSearch

final class MockQueue: Dispatching {
    func async(execute workItem: DispatchWorkItem) {
        workItem.perform()
    }
}
