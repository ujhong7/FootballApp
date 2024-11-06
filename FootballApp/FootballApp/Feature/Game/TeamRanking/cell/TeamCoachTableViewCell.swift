//  TeamCoachTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 11/2/24.
//

import UIKit

class TeamCoachTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TeamCoachTableViewCell"
    
    private let coachImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25 // 원형 이미지
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        contentView.addSubview(coachImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Coach ImageView
            coachImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coachImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coachImageView.widthAnchor.constraint(equalToConstant: 50),
            coachImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Name Label
            nameLabel.leadingAnchor.constraint(equalTo: coachImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            // Age Label
            ageLabel.leadingAnchor.constraint(equalTo: coachImageView.trailingAnchor, constant: 16),
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            ageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with coach: CoachInfo) {
        nameLabel.text = coach.name
        ageLabel.text = "Age: \(coach.age)"
        coachImageView.loadImage(from: coach.photo)
    }
}
