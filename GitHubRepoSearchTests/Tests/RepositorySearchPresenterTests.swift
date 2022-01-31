//
//  RepositorySearchPresenterTests.swift
//  GitHubRepoSearchTests
//
//  Created by Michał Warchał on 31/01/2022.
//

import XCTest
@testable import GitHubRepoSearch

class RepositorySearchPresenterTests: XCTestCase {
    
    var sut: RepositorySearchDefaultPresenter!
    
    var router: MockRepositorySearchRouter!
    var gitHubRepositoryService: MockGitHubRepositoryService!
    var interactor: RepositorySearchInteractor!
    var viewInterface: MockRepositorySearchViewInterface!
    
    override func setUp() {
        super.setUp()
        router = MockRepositorySearchRouter()
        gitHubRepositoryService = MockGitHubRepositoryService()
        interactor = RepositorySearchDefaultInteractor(repositoryService: gitHubRepositoryService)
        viewInterface = MockRepositorySearchViewInterface()
        sut = RepositorySearchDefaultPresenter(interactor: interactor, router: router, queue: MockQueue())
    }

    override func tearDown() {
        router = nil
        gitHubRepositoryService = nil
        interactor = nil
        viewInterface = nil
        sut = nil
        super.tearDown()
    }
    
    func testCellViewModelsIsEmptyWithoutFetchingData() {
        XCTAssertTrue(sut.cellViewModels.isEmpty)
    }
    
    func testSearchQueryCallsGitHubRepositoryServiceWithQuery() {
        let query = "search query"
        sut.handleSearchQueryChanged(searchQuery: query)
        
        XCTAssertEqual(gitHubRepositoryService.query, query)
    }
    
    func testCellViewModelsFilledAfterSuccessfulQuery() {
        let items: [GitHubRepository] = [
            GitHubRepository(id: 0, name: "name", url: "https://github.com"),
            GitHubRepository(id: 1, name: "name", url: "https://github.com"),
        ]
        gitHubRepositoryService.result = .success(items)
        
        sut.handleSearchQueryChanged(searchQuery: "query")
        
        XCTAssertEqual(sut.cellViewModels.count, items.count)
        XCTAssertEqual(sut.cellViewModels[0].id, items[0].id)
        XCTAssertEqual(sut.cellViewModels[0].name, items[0].name)
    }
    
    func testViewUpdatedAfterSuccessfulQuery() {
        sut.attach(view: viewInterface)
        sut.handleSearchQueryChanged(searchQuery: "query")
        
        XCTAssertTrue(viewInterface.wasUpdateDataSourceCalled)
    }
    
    func testWasUserInteractionDisabledDuringSearchCall() {
        sut.attach(view: viewInterface)
        gitHubRepositoryService.shouldCallCompletion = false
        
        sut.handleSearchQueryChanged(searchQuery: "query")
        XCTAssertFalse(viewInterface.isUserInteractionEnabled)
    }
    
    func testShowAlertIsCalledOnError() {
        gitHubRepositoryService.result = .failure(NetworkError.general)
        
        sut.handleSearchQueryChanged(searchQuery: "query")
        XCTAssertNotNil(router.errorToShow)
    }
    
    func testSelectingRowCallsRouterToOpenURL() {
        let stringPath = "https://github.com"
        let items: [GitHubRepository] = [GitHubRepository(id: 0, name: "name", url: stringPath)]
        gitHubRepositoryService.result = .success(items)
        sut.handleSearchQueryChanged(searchQuery: "query")
        
        sut.didSelectRow(at: 0)
        XCTAssertEqual(router.urlToOpen, URL(string: stringPath))
    }
}
