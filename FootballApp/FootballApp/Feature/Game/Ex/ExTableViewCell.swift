//
//  ExTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/16/24.
//


import UIKit

class ExTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ExTableViewCell"
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    func configure(with fixture: Fixture) {
        
    }
    
}

