//
//  Dispatching.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 31/01/2022.
//

import Foundation

protocol Dispatching {
    func async(execute workItem: DispatchWorkItem)
}

extension DispatchQueue: Dispatching { }
