//
//  RepositorySearchViewController.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 29/01/2022.
//

import UIKit

protocol RepositorySearchViewInterface: AnyObject {
    var isUserInteractionEnabled: Bool { get set }
    func updateDataSource()
}

class RepositorySearchViewController: UIViewController {
    
    var isUserInteractionEnabled: Bool {
        get { view.isUserInteractionEnabled }
        set { view.isUserInteractionEnabled = newValue }
    }
    
    private let presenter: RepositorySearchPresenter

    private lazy var repositorySearchView: RepositorySearchView = {
        let view = RepositorySearchView(frame: .zero)
        view.searchBar.delegate = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        return view
    }()
    
    init(presenter: RepositorySearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = repositorySearchView
    }
}

extension RepositorySearchViewController: RepositorySearchViewInterface {
    func updateDataSource() {
        repositorySearchView.tableView.reloadData()
    }
}

extension RepositorySearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.handleSearchQueryChanged(searchQuery: searchBar.text)
        searchBar.endEditing(true)
    }
}

extension RepositorySearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = presenter.cellViewModels[indexPath.row]
        cell.setup(with: viewModel)
        cell.selectionStyle = .none
        return cell
    }
}

extension RepositorySearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row)
    }
}

extension RepositorySearchViewController {
    static func build() -> RepositorySearchViewController {
        let interactor = RepositorySearchDefaultInteractor()
        let router = RepositorySearchDefaultRouter()
        let presenter = RepositorySearchDefaultPresenter(interactor: interactor,
                                                         router: router)
        let viewController = RepositorySearchViewController(presenter: presenter)
        
        presenter.attach(view: viewController)
        router.addViewController(viewController)

        return viewController
    }
}
