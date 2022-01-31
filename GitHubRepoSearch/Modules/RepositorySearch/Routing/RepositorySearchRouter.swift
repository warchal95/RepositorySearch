//
//  RepositorySearchRouter.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 29/01/2022.
//

import UIKit

protocol RepositorySearchRouter {
    func openURL(_ url: URL)
    func showError(_ error: Error)
}

class RepositorySearchDefaultRouter {

    private weak var viewController: UIViewController?
    private weak var uiApplication: UIApplication?

    init(uiApplication: UIApplication = UIApplication.shared) {
        self.uiApplication = uiApplication
    }
    
    func addViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension RepositorySearchDefaultRouter: RepositorySearchRouter {
    func openURL(_ url: URL) {
        uiApplication?.open(url)
    }
    
    func showError(_ error: Error) {
        let alertViewController = UIAlertController(title: NSLocalizedString("error_alert_title",
                                                                             comment: "Something Went Wrong Alert Title"),
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: NSLocalizedString("common_cancel",
                                                                             comment: "Cancel alert button"),
                                                    style: .cancel,
                                                    handler: nil))
        viewController?.present(alertViewController, animated: true)
    }
}
