//
//  GitHubRepositoryResponse.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 30/01/2022.
//

import Foundation

struct GitHubRepositoryResponse: Decodable {
    let items: [GitHubRepository]
}

struct GitHubRepository: Decodable {
    let id: Int
    let name: String
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "html_url"
    }
}
