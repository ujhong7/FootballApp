//
//  PlayerStatsTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/23/24.
//

import UIKit

class PlayerStatsTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "PlayerStatsTableViewCell"
    
    // MARK: Properties
    
    private let appearancesLabel = UILabel()
    private let lineupsLabel = UILabel()
    private let minutesLabel = UILabel()
    private let positionLabel = UILabel()
    private let ratingLabel = UILabel()
    private let shotsLabel = UILabel()
    private let goalsLabel = UILabel()
    private let assistsLabel = UILabel()
    private let passesLabel = UILabel()
    private let tacklesLabel = UILabel()
    private let dribblesLabel = UILabel()
    private let foulsLabel = UILabel()
    private let yellowCardsLabel = UILabel()
    private let redCardsLabel = UILabel()
    private let penaltyLabel = UILabel()
    
    // MARK: - init
    
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
        // Label settings
        let labels = [appearancesLabel, lineupsLabel, minutesLabel, positionLabel, ratingLabel, shotsLabel, goalsLabel, assistsLabel, passesLabel, tacklesLabel, dribblesLabel, foulsLabel, yellowCardsLabel, redCardsLabel, penaltyLabel]
        for label in labels {
            label.font = .systemFont(ofSize: 14, weight: .regular)
            label.numberOfLines = 1
            contentView.addSubview(label)
        }
    }
    
    private func setupConstraints() {
        // Disable autoresizing mask
        let labels = [appearancesLabel, lineupsLabel, minutesLabel, positionLabel, ratingLabel, shotsLabel, goalsLabel, assistsLabel, passesLabel, tacklesLabel, dribblesLabel, foulsLabel, yellowCardsLabel, redCardsLabel, penaltyLabel]
        for label in labels {
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            appearancesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            appearancesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            lineupsLabel.topAnchor.constraint(equalTo: appearancesLabel.bottomAnchor, constant: 5),
            lineupsLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            minutesLabel.topAnchor.constraint(equalTo: lineupsLabel.bottomAnchor, constant: 5),
            minutesLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            positionLabel.topAnchor.constraint(equalTo: minutesLabel.bottomAnchor, constant: 5),
            positionLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 5),
            ratingLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            shotsLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            shotsLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            goalsLabel.topAnchor.constraint(equalTo: shotsLabel.bottomAnchor, constant: 5),
            goalsLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            assistsLabel.topAnchor.constraint(equalTo: goalsLabel.bottomAnchor, constant: 5),
            assistsLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            passesLabel.topAnchor.constraint(equalTo: assistsLabel.bottomAnchor, constant: 5),
            passesLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            tacklesLabel.topAnchor.constraint(equalTo: passesLabel.bottomAnchor, constant: 5),
            tacklesLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            dribblesLabel.topAnchor.constraint(equalTo: tacklesLabel.bottomAnchor, constant: 5),
            dribblesLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            foulsLabel.topAnchor.constraint(equalTo: dribblesLabel.bottomAnchor, constant: 5),
            foulsLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            yellowCardsLabel.topAnchor.constraint(equalTo: foulsLabel.bottomAnchor, constant: 5),
            yellowCardsLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            redCardsLabel.topAnchor.constraint(equalTo: yellowCardsLabel.bottomAnchor, constant: 5),
            redCardsLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            
            penaltyLabel.topAnchor.constraint(equalTo: redCardsLabel.bottomAnchor, constant: 5),
            penaltyLabel.leadingAnchor.constraint(equalTo: appearancesLabel.leadingAnchor),
            penaltyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with playerResponse: PlayerResponse) {
        guard let stats = playerResponse.statistics?.first else { return } // 첫 번째 통계 데이터 사용
        
        // Games Stats
        appearancesLabel.text = "출장 횟수: \(stats.games.appearences)"
        lineupsLabel.text = "선발 출전: \(stats.games.lineups)"
        minutesLabel.text = "출전 시간: \(stats.games.minutes)분"
        positionLabel.text = "포지션: " + stats.games.position
        ratingLabel.text = "평점: " + stats.games.rating
        
        // Shots and Goals
        shotsLabel.text = "슈팅 (유효슈팅/총 슈팅): \(stats.shots.on)/\(stats.shots.total)"
        goalsLabel.text = "득점: \(stats.goals.total)골"
        assistsLabel.text = "도움: \(stats.goals.assists)회"
        
        // Passes
        passesLabel.text = "패스 (총 패스/키 패스): \(stats.passes.total)/\(stats.passes.key)"
        
        // Tackles and Dribbles
        tacklesLabel.text = "태클: \(stats.tackles.total)회"
        dribblesLabel.text = "드리블 (성공/시도): \(stats.dribbles.success)/\(stats.dribbles.attempts)"
        
        // Fouls
        foulsLabel.text = "파울 (가한 파울/당한 파울): \(stats.fouls.committed)/\(stats.fouls.drawn)"
        
        // Cards
        yellowCardsLabel.text = "옐로우카드: \(stats.cards.yellow)장"
        redCardsLabel.text =  "레드카드: \(stats.cards.red)장"
        
        // Penalties
        if let scored = stats.penalty.scored as Int?, let missed = stats.penalty.missed as Int? {
            penaltyLabel.text = "페널티 (성공/실패): \(stats.penalty.scored)/\(stats.penalty.missed)"
        } else {
            penaltyLabel.text = "No penalty data"
        }
    }
    
}
