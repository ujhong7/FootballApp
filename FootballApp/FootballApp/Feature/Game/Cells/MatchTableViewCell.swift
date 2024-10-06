//
//  MatchTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let homeTeamLogoImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let homeGoalsLabel = UILabel()
    
    private let awayGoalsLabel = UILabel()
    private let awayTeamNameLabel = UILabel()
    private let awayTeamLogoImageView = UIImageView()
    
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Configure image views and labels
        homeTeamLogoImageView.contentMode = .scaleAspectFit
        awayTeamLogoImageView.contentMode = .scaleAspectFit
        homeTeamNameLabel.font = .systemFont(ofSize: 12, weight: .bold)
        awayTeamNameLabel.font = .systemFont(ofSize: 12, weight: .bold)
        homeGoalsLabel.font = .systemFont(ofSize: 12)
        awayGoalsLabel.font = .systemFont(ofSize: 12)
        statusLabel.font = .systemFont(ofSize: 10, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        
        homeTeamNameLabel.numberOfLines = 2
        awayTeamNameLabel.numberOfLines = 2
        
        // Add subviews
        contentView.addSubview(homeTeamLogoImageView)
        contentView.addSubview(homeTeamNameLabel)
        contentView.addSubview(homeGoalsLabel)
        contentView.addSubview(awayGoalsLabel)
        contentView.addSubview(awayTeamNameLabel)
        contentView.addSubview(awayTeamLogoImageView)
        contentView.addSubview(statusLabel)
        contentView.addSubview(dateLabel)
        
        // Set up constraints
        setupConstraints()
    }
    
    private func setupConstraints() {
        homeTeamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        homeTeamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        homeGoalsLabel.translatesAutoresizingMaskIntoConstraints = false
        awayGoalsLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Home Team Logo
            homeTeamLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            homeTeamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            homeTeamLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            homeTeamLogoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // Home Team Name
            homeTeamNameLabel.leadingAnchor.constraint(equalTo: homeTeamLogoImageView.trailingAnchor, constant: 10),
            homeTeamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            homeTeamNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            // Home Goals
            homeGoalsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            homeGoalsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15),
            
            // Away Goals
            awayGoalsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            awayGoalsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15),
            
            // Away Team Name
            awayTeamNameLabel.trailingAnchor.constraint(equalTo: awayTeamLogoImageView.leadingAnchor, constant: -10),
            awayTeamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            awayTeamNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            // Away Team Logo
            awayTeamLogoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            awayTeamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            awayTeamLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            awayTeamLogoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // Status Label
            statusLabel.topAnchor.constraint(equalTo: homeTeamLogoImageView.bottomAnchor, constant: 5),
            statusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Date Label
            dateLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
}

extension MatchTableViewCell {
    func configure(with homeTeam: String, homeLogo: String, awayTeam: String, awayLogo: String, homeGoals: Int?, awayGoals: Int?, status: String, date: String) {
        homeTeamNameLabel.text = homeTeam
        awayTeamNameLabel.text = awayTeam
        homeGoalsLabel.text = "\(homeGoals ?? 0)"
        awayGoalsLabel.text = "\(awayGoals ?? 0)"
        statusLabel.text = status
        dateLabel.text = formatDate(date)
        
        // 로고 이미지 로드
        homeTeamLogoImageView.loadImage(from: homeLogo)
        awayTeamLogoImageView.loadImage(from: awayLogo)
    }
    
    private func formatDate(_ dateString: String) -> String {
        // 날짜 형식 변환 로직 (필요한 경우)
        // 예시: ISO8601 문자열을 Date로 변환 후 포맷할 수 있음
        return dateString // 변환된 날짜 문자열 반환
    }
}


// MARK: - UIImageView Extension for Image Loading
extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
