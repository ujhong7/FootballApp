//
//  TeamRankingTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

class TeamRankingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TeamRankingTableViewCell"
    
    let rankLabel = UILabel()
    let teamLogoImageView = UIImageView()
    let teamNameLabel = UILabel()
    let matchesLabel = UILabel()
    let pointsLabel = UILabel()
    let winsLabel = UILabel()
    let drawsLabel = UILabel()
    let lossesLabel = UILabel()
    let goalDifferenceLabel = UILabel()
    let goalsForLabel = UILabel()
    let goalsAgainstLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        [rankLabel, teamLogoImageView, teamNameLabel, matchesLabel, pointsLabel, winsLabel, drawsLabel, lossesLabel, goalDifferenceLabel, goalsForLabel, goalsAgainstLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        let baseLeading: CGFloat = 140 // 기본 위치
        let spacing: CGFloat = 30      // 간격
        
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 43),
            teamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamLogoImageView.widthAnchor.constraint(equalToConstant: 30), // ⭐️
            teamLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 87),
            teamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            matchesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseLeading),
            matchesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            pointsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseLeading + spacing),
            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            winsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseLeading + (spacing * 2)),
            winsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            drawsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseLeading + (spacing * 3)),
            drawsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            lossesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseLeading + (spacing * 4)),
            lossesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            goalDifferenceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseLeading + (spacing * 5)),
            goalDifferenceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            goalsForLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseLeading + (spacing * 6)),
            goalsForLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            goalsAgainstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: baseLeading + (spacing * 7)),
            goalsAgainstLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(with teamStats: TeamStats) {
        rankLabel.text = "\(teamStats.rank)" // 순위를 문자열로 변환하여 설정
        //        teamNameLabel.text = teamStats.team.name // 팀 이름 설정
        teamNameLabel.text = teamAbbreviations[teamStats.team.name] ?? teamStats.team.name // 약어 설정
        matchesLabel.text = "\(teamStats.all.played)" // 경기수 설정
        pointsLabel.text = "\(teamStats.points)" // 승점 설정
        winsLabel.text = "\(teamStats.all.win)" // 승리 수 설정
        drawsLabel.text = "\(teamStats.all.draw)" // 무승부 수 설정
        lossesLabel.text = "\(teamStats.all.lose)" // 패배 수 설정
        goalDifferenceLabel.text = "\(teamStats.goalsDiff)" // 득실차 설정
        goalsForLabel.text = "\(teamStats.all.goals.forGoals)" // 득점 설정
        goalsAgainstLabel.text = "\(teamStats.all.goals.against)" // 실점 설정
        
        // 팀 로고 이미지 설정
        teamLogoImageView.loadImage(from: teamStats.team.logo) // 이미지 로드
    }
    
}

