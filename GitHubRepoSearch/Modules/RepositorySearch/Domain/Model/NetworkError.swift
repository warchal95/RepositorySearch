//
//  NetworkError.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 30/01/2022.
//

import Foundation

enum NetworkError: Error {
    case general
    case parsing
    case requestMalformed
}
