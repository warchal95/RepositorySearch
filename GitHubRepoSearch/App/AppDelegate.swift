//
//  AppDelegate.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 29/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = RepositorySearchViewController.build()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
