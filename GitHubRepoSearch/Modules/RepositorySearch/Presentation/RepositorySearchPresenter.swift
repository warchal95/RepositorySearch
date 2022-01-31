//
//  RepositorySearchPresenter.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 29/01/2022.
//

import Foundation

protocol RepositorySearchPresenter {
    var cellViewModels: [RepositoryCellViewModel] { get }
    func handleSearchQueryChanged(searchQuery: String?)
    func didSelectRow(at index: Int)
}

class RepositorySearchDefaultPresenter {

    var cellViewModels: [RepositoryCellViewModel] = []

    private let interactor: RepositorySearchInteractor
    private let router: RepositorySearchRouter
    private weak var view: RepositorySearchViewInterface?
    private let queue: Dispatching

    private var gitHubRepositories: [GitHubRepository] = []
    
    init(interactor: RepositorySearchInteractor,
         router: RepositorySearchRouter,
         queue: Dispatching = DispatchQueue.main) {
        self.interactor = interactor
        self.router = router
        self.queue = queue
    }
    
    func attach(view: RepositorySearchViewInterface) {
        self.view = view
    }
}

extension RepositorySearchDefaultPresenter: RepositorySearchPresenter {
    func handleSearchQueryChanged(searchQuery: String?) {
        guard let query = searchQuery else {
            return
        }
        
        view?.isUserInteractionEnabled = false

        interactor.searchForRepositories(query: query) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.cellViewModels = repositories.map {
                    RepositoryCellViewModel(id: $0.id, name: $0.name)
                }
                self?.gitHubRepositories = repositories
                
                self?.queue.async(execute: DispatchWorkItem(block: {
                    self?.view?.updateDataSource()
                    self?.view?.isUserInteractionEnabled = true
                }))
            case .failure(let error):
                self?.queue.async(execute: DispatchWorkItem(block: {
                    self?.router.showError(error)
                    self?.view?.isUserInteractionEnabled = true
                }))
            }
        }
    }
    
    func didSelectRow(at index: Int) {
        let identifier = cellViewModels[index].id
        guard
            let repository = gitHubRepositories.first(where: { $0.id == identifier }),
            let url = URL(string: repository.url)
        else {
            return
        }
        router.openURL(url)
    }
}
