//
//  TeamSquadTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 11/1/24.
//

import UIKit

class TeamSquadTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TeamSquadTableViewCell"
    
    private let playerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        contentView.addSubview(playerImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(ageLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Player ImageView
            playerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            playerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 50),
            playerImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Name Label
            nameLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            // Number Label
            numberLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 16),
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            // Age Label
            ageLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 16),
            ageLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 4),
            ageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with player: Player3) {
        nameLabel.text = player.name
        numberLabel.text = player.number != nil ? "No: \(player.number!)" : "No: -"
        ageLabel.text = "Age: \(player.age)"
        playerImageView.loadImage(from: player.photo)
    }
    
}

