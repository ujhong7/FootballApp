//
//  RoundTabCollectionViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/14/24.
//

import UIKit

class RoundTabCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "RoundCollectionViewCell"
    private let roundLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
//        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        roundLabel.backgroundColor = .premierLeagueBackgroundColor
        roundLabel.textColor = .premierLeaguePurple
        roundLabel.font = .systemFont(ofSize: 16, weight: .bold)
        roundLabel.layer.cornerRadius = 10
        roundLabel.layer.masksToBounds = true
        roundLabel.layer.borderWidth = 1
        roundLabel.layer.borderColor = UIColor.premierLeaguePurple.cgColor
        roundLabel.textAlignment = .center
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(roundLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            roundLabel.widthAnchor.constraint(equalToConstant: 45),
            roundLabel.heightAnchor.constraint(equalToConstant: 30),
            roundLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(round: Int) {
        roundLabel.text = "\(round) R"
    }
    
    func changeBackgroundColor(isSelected: Bool) {
        roundLabel.backgroundColor = isSelected ? .premierLeaguePurple : .premierLeagueBackgroundColor
        roundLabel.textColor = isSelected ? .white : .premierLeaguePurple
    }
}
