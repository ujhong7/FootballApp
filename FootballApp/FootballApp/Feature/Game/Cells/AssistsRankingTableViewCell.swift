//
//  AssistsRankingTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/5/24.
//

import UIKit

class AssistsRankingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "AssistsRankingTableViewCell"
    
    let rankLabel = UILabel()
    let playerImageView = UIImageView()
    let playerNameLabel = UILabel()
    let teamLogoImageView = UIImageView()
    let matchesLabel = UILabel()
    let assistsLabel = UILabel()
    
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
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true
        playerImageView.layer.cornerRadius = 20
        
        // 레이블의 텍스트 색상 설정
        rankLabel.textColor = .premierLeaguePurple
        playerNameLabel.textColor = .premierLeaguePurple
        matchesLabel.textColor = .premierLeaguePurple
        assistsLabel.textColor = .premierLeaguePurple
        
        teamLogoImageView.contentMode = .scaleAspectFit
        teamLogoImageView.clipsToBounds = true
        
        [rankLabel, playerImageView, playerNameLabel, teamLogoImageView, matchesLabel, assistsLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            playerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 30),
            playerImageView.heightAnchor.constraint(equalToConstant: 30),
            
            playerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            playerNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 235),
            teamLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            teamLogoImageView.heightAnchor.constraint(equalToConstant: 40),
            
            matchesLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            matchesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            assistsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            assistsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(with playerRanking: PlayerRanking, rank: Int) {
        rankLabel.text = "\(rank)"
        playerNameLabel.text = playerRanking.player.name
        matchesLabel.text = "\(playerRanking.statistics.first?.games.appearences ?? 0)"
        assistsLabel.text = "\(playerRanking.statistics.first?.goals.assists ?? 0)"
        
        teamLogoImageView.loadImage(from: playerRanking.statistics.first?.team.logo ?? "")
        playerImageView.loadImage(from: playerRanking.player.photo)
    }
}
