//
//  MatchTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MatchTableViewCell"
    
    private let homeTeamLogoImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let homeGoalsLabel = UILabel()
    private let awayGoalsLabel = UILabel()
    private let awayTeamNameLabel = UILabel()
    private let awayTeamLogoImageView = UIImageView()
    private let statusLabel = UILabel()
    private let dateLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .premierLeagueBackgroundColor
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        homeTeamLogoImageView.contentMode = .scaleAspectFit
        awayTeamLogoImageView.contentMode = .scaleAspectFit
        homeTeamNameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        awayTeamNameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        homeGoalsLabel.font = .systemFont(ofSize: 16, weight: .bold)
        awayGoalsLabel.font = .systemFont(ofSize: 16, weight: .bold)
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        // 텍스트 색상 설정
        homeTeamNameLabel.textColor = .premierLeaguePurple
        awayTeamNameLabel.textColor = .premierLeaguePurple
        homeGoalsLabel.textColor = .premierLeaguePurple
        awayGoalsLabel.textColor = .premierLeaguePurple
        statusLabel.textColor = .premierLeaguePurple
        dateLabel.textColor = .premierLeaguePurple
        
        
        homeTeamNameLabel.numberOfLines = 2
        awayTeamNameLabel.numberOfLines = 2
        
        [homeTeamLogoImageView, homeTeamNameLabel, homeGoalsLabel, awayGoalsLabel,
         awayTeamNameLabel, awayTeamLogoImageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        } // statusLabel, dateLabel
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            homeTeamLogoImageView.trailingAnchor.constraint(equalTo: homeGoalsLabel.leadingAnchor, constant: -13),
            homeTeamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            homeTeamLogoImageView.widthAnchor.constraint(equalToConstant: 30),
            homeTeamLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            
            homeTeamNameLabel.trailingAnchor.constraint(equalTo: homeTeamLogoImageView.leadingAnchor, constant: -10), // ⭐️
            homeTeamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            homeTeamNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            // fix
            homeGoalsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            homeGoalsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15),
            
            awayGoalsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            awayGoalsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15),
            
            awayTeamNameLabel.leadingAnchor.constraint(equalTo: awayTeamLogoImageView.trailingAnchor, constant: 10),
            awayTeamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            awayTeamNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            awayTeamLogoImageView.leadingAnchor.constraint(equalTo: awayGoalsLabel.trailingAnchor, constant: 13),
            awayTeamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            awayTeamLogoImageView.widthAnchor.constraint(equalToConstant: 30),
            awayTeamLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            
//            statusLabel.topAnchor.constraint(equalTo: homeTeamLogoImageView.bottomAnchor, constant: 5),
//            statusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            
//            dateLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
//            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
}

extension MatchTableViewCell {
    func configure(with fixture: Fixture) {
        let homeTeam = fixture.teams.home
        let awayTeam = fixture.teams.away
        let homeGoals = fixture.goals.home
        let awayGoals = fixture.goals.away
        let status = fixture.fixture.status.long
        let date = fixture.fixture.date
        
        homeTeamNameLabel.text = homeTeam.name
        awayTeamNameLabel.text = awayTeam.name
        homeGoalsLabel.text = "\(homeGoals ?? 0)"
        awayGoalsLabel.text = "\(awayGoals ?? 0)"
        statusLabel.text = status
        dateLabel.text = formatDate(date)
        
        // 로고 이미지 로드
        homeTeamLogoImageView.loadImage(from: homeTeam.logo)
        awayTeamLogoImageView.loadImage(from: awayTeam.logo)
    }
    
    private func formatDate(_ dateString: String) -> String {
        // 날짜 형식 변환 로직 (필요한 경우)
        // 예시: ISO8601 문자열을 Date로 변환 후 포맷할 수 있음
        return dateString // 변환된 날짜 문자열 반환
    }
}
