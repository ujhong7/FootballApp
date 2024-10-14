//
//  RoundCollectionViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/14/24.
//

import UIKit

class RoundCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "RoundCollectionViewCell"
    
    private let roundLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        roundLabel.backgroundColor = .systemGray6
        roundLabel.textColor = .black
        roundLabel.font = .systemFont(ofSize: 16, weight: .bold)
        roundLabel.layer.cornerRadius = 10
        roundLabel.textAlignment = .center
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(roundLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            roundLabel.widthAnchor.constraint(equalToConstant: 50),
            roundLabel.heightAnchor.constraint(equalToConstant: 50),
            roundLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(round: Int) {
        roundLabel.text = "\(round)"
    }
    
    func changeBackgroundColor(isSelected: Bool) {
        roundLabel.backgroundColor = isSelected ? .premierLeaguePurple : .systemGray6
        roundLabel.textColor = isSelected ? .white : .black
    }
}
