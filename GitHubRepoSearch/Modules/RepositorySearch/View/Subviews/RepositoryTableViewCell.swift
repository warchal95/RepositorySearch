//
//  RepositoryTableViewCell.swift
//  GitHubRepoSearch
//
//  Created by Michał Warchał on 30/01/2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    static let identifier = "RepositoryTableViewCellIdentifier"

    private enum Constants {
        static let marginOffset: CGFloat = 12
        static let fontSize: CGFloat = 16
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.marginOffset),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.marginOffset),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setup(with viewModel: RepositoryCellViewModel) {
        nameLabel.text = viewModel.name
    }
}
