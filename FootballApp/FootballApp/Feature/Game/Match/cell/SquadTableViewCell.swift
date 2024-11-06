//
//  SquadTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/28/24.
//

import UIKit

class SquadTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SquadTableViewCell"
    
    private let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let homeCoachLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let awayCoachLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let homeFormationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let awayFormationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let homeStartingPlayersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "선발"
        return label
    }()
    
    private let awayStartingPlayersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "선발"
        return label
    }()
    
    private let homeSubstitutesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "교체명단"
        return label
    }()
    
    private let awaySubstitutesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "교체명단"
        return label
    }()
    
    private let homeStartingPlayersStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let awayStartingPlayersStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let homeSubstitutesStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let awaySubstitutesStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
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
        // UI 요소 추가
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(homeCoachLabel)
        contentView.addSubview(awayCoachLabel)
        contentView.addSubview(homeFormationLabel)
        contentView.addSubview(awayFormationLabel)
        
        // 선발 및 교체명단 레이블 추가
        contentView.addSubview(homeStartingPlayersLabel)
        contentView.addSubview(awayStartingPlayersLabel)
        contentView.addSubview(homeSubstitutesLabel)
        contentView.addSubview(awaySubstitutesLabel)
        
        contentView.addSubview(homeStartingPlayersStack)
        contentView.addSubview(awayStartingPlayersStack)
        contentView.addSubview(homeSubstitutesStack)
        contentView.addSubview(awaySubstitutesStack)
    }
    
    private func setupConstraints() {
        // 제약 조건 설정
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        homeCoachLabel.translatesAutoresizingMaskIntoConstraints = false
        awayCoachLabel.translatesAutoresizingMaskIntoConstraints = false
        homeFormationLabel.translatesAutoresizingMaskIntoConstraints = false
        awayFormationLabel.translatesAutoresizingMaskIntoConstraints = false
        homeStartingPlayersLabel.translatesAutoresizingMaskIntoConstraints = false
        awayStartingPlayersLabel.translatesAutoresizingMaskIntoConstraints = false
        homeSubstitutesLabel.translatesAutoresizingMaskIntoConstraints = false
        awaySubstitutesLabel.translatesAutoresizingMaskIntoConstraints = false
        homeStartingPlayersStack.translatesAutoresizingMaskIntoConstraints = false
        awayStartingPlayersStack.translatesAutoresizingMaskIntoConstraints = false
        homeSubstitutesStack.translatesAutoresizingMaskIntoConstraints = false
        awaySubstitutesStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeTeamLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            awayTeamLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            awayTeamLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            homeCoachLabel.leadingAnchor.constraint(equalTo: homeTeamLabel.leadingAnchor),
            homeCoachLabel.topAnchor.constraint(equalTo: homeTeamLabel.bottomAnchor, constant: 4),
            
            awayCoachLabel.trailingAnchor.constraint(equalTo: awayTeamLabel.trailingAnchor),
            awayCoachLabel.topAnchor.constraint(equalTo: awayTeamLabel.bottomAnchor, constant: 4),
            
            homeFormationLabel.leadingAnchor.constraint(equalTo: homeTeamLabel.leadingAnchor),
            homeFormationLabel.topAnchor.constraint(equalTo: homeCoachLabel.bottomAnchor, constant: 4),
            
            awayFormationLabel.trailingAnchor.constraint(equalTo: awayTeamLabel.trailingAnchor),
            awayFormationLabel.topAnchor.constraint(equalTo: awayCoachLabel.bottomAnchor, constant: 4),
            
            // 선발 레이블 제약 조건
            homeStartingPlayersLabel.leadingAnchor.constraint(equalTo: homeTeamLabel.leadingAnchor),
            homeStartingPlayersLabel.topAnchor.constraint(equalTo: homeFormationLabel.bottomAnchor, constant: 8),
            
            awayStartingPlayersLabel.trailingAnchor.constraint(equalTo: awayTeamLabel.trailingAnchor),
            awayStartingPlayersLabel.topAnchor.constraint(equalTo: awayFormationLabel.bottomAnchor, constant: 8),
            
            // 주전 선수 스택 제약 조건
            homeStartingPlayersStack.leadingAnchor.constraint(equalTo: homeStartingPlayersLabel.leadingAnchor),
            homeStartingPlayersStack.topAnchor.constraint(equalTo: homeStartingPlayersLabel.bottomAnchor, constant: 4),
            
            awayStartingPlayersStack.trailingAnchor.constraint(equalTo: awayStartingPlayersLabel.trailingAnchor),
            awayStartingPlayersStack.topAnchor.constraint(equalTo: awayStartingPlayersLabel.bottomAnchor, constant: 4),
            
            // 교체명단 레이블 제약 조건
            homeSubstitutesLabel.leadingAnchor.constraint(equalTo: homeTeamLabel.leadingAnchor),
            homeSubstitutesLabel.topAnchor.constraint(equalTo: homeStartingPlayersStack.bottomAnchor, constant: 8),
            
            awaySubstitutesLabel.trailingAnchor.constraint(equalTo: awayTeamLabel.trailingAnchor),
            awaySubstitutesLabel.topAnchor.constraint(equalTo: awayStartingPlayersStack.bottomAnchor, constant: 8),
            
            // 교체 선수 스택 제약 조건
            homeSubstitutesStack.leadingAnchor.constraint(equalTo: homeSubstitutesLabel.leadingAnchor),
            homeSubstitutesStack.topAnchor.constraint(equalTo: homeSubstitutesLabel.bottomAnchor, constant: 4),
            homeSubstitutesStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            awaySubstitutesStack.trailingAnchor.constraint(equalTo: awaySubstitutesLabel.trailingAnchor),
            awaySubstitutesStack.topAnchor.constraint(equalTo: awaySubstitutesLabel.bottomAnchor, constant: 4),
            awaySubstitutesStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // 포지션에 따른 이모지를 반환하는 함수
    private func emojiForPosition(_ position: String?) -> String {
        switch position {
        case "G":
            return "🟨" // 골키퍼
        case "D":
            return "🟦" // 수비수
        case "M":
            return "🟩" // 미드필더
        case "F":
            return "🟥" // 공격수
        default:
            return ""
        }
    }
    
    // MARK: - Configuration Method
    
    func configure(with fixture: Fixture) {
        configureHomeTeam(fixture: fixture)
        configureAwayTeam(fixture: fixture)
    }

    private func configureHomeTeam(fixture: Fixture) {
        guard let homeTeam = fixture.teams?.home else { return }
        homeTeamLabel.text = homeTeam.name
        
        if let homeLineup = fixture.lineups?.first(where: { $0.team.id == homeTeam.id }) {
            homeCoachLabel.text = "Coach: \(homeLineup.coach.name ?? "No Data")"
            homeFormationLabel.text = "Formation: \(homeLineup.formation)"
            
            configureStartingPlayers(homeLineup.startXI, in: homeStartingPlayersStack)
            configureSubstitutePlayers(homeLineup.substitutes, in: homeSubstitutesStack)
        }
    }

    private func configureAwayTeam(fixture: Fixture) {
        guard let awayTeam = fixture.teams?.away else { return }
        awayTeamLabel.text = awayTeam.name
        
        if let awayLineup = fixture.lineups?.first(where: { $0.team.id == awayTeam.id }) {
            awayCoachLabel.text = "Coach: \(awayLineup.coach.name ?? "No Data")"
            awayFormationLabel.text = "Formation: \(awayLineup.formation)"
            
            configureStartingPlayers(awayLineup.startXI, in: awayStartingPlayersStack)
            configureSubstitutePlayers(awayLineup.substitutes, in: awaySubstitutesStack)
        }
    }

    // 선발 선수 배열을 받아 라벨을 추가하는 메서드
    private func configureStartingPlayers(_ startingPlayers: [StartingPlayer]?, in stackView: UIStackView) {
        guard let startingPlayers = startingPlayers else { return }
        
        for startingPlayer in startingPlayers {
            let playerLabel = createPlayerLabel(with: startingPlayer.player?.name, position: startingPlayer.player?.pos)
            stackView.addArrangedSubview(playerLabel)
        }
    }

    // 교체 선수 배열을 받아 라벨을 추가하는 메서드
    private func configureSubstitutePlayers(_ substitutes: [SubstitutePlayer], in stackView: UIStackView) {
        for substitute in substitutes {
            let playerLabel = createPlayerLabel(with: substitute.player.name, position: substitute.player.pos)
            stackView.addArrangedSubview(playerLabel)
        }
    }

    // 포지션에 맞는 이모지와 이름으로 UILabel을 생성하는 메서드
    private func createPlayerLabel(with name: String?, position: String?) -> UILabel {
        let playerLabel = UILabel()
        playerLabel.font = UIFont.systemFont(ofSize: 14)
        
        let emoji = emojiForPosition(position)
        let playerName = name ?? "Unknown"
        playerLabel.text = "\(emoji) \(playerName)"
        
        return playerLabel
    }
    
}
