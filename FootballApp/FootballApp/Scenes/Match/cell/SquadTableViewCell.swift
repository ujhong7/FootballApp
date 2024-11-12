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
    
    private let startingPlayersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "선발"
        return label
    }()
    
    private let substitutesLabel: UILabel = {
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
        contentView.addSubview(startingPlayersLabel)
        contentView.addSubview(substitutesLabel)
        
        contentView.addSubview(homeStartingPlayersStack)
        contentView.addSubview(awayStartingPlayersStack)
        contentView.addSubview(homeSubstitutesStack)
        contentView.addSubview(awaySubstitutesStack)
    }
    
    private func setupConstraints() {
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        homeCoachLabel.translatesAutoresizingMaskIntoConstraints = false
        awayCoachLabel.translatesAutoresizingMaskIntoConstraints = false
        homeFormationLabel.translatesAutoresizingMaskIntoConstraints = false
        awayFormationLabel.translatesAutoresizingMaskIntoConstraints = false
        startingPlayersLabel.translatesAutoresizingMaskIntoConstraints = false
        substitutesLabel.translatesAutoresizingMaskIntoConstraints = false
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
            startingPlayersLabel.leadingAnchor.constraint(equalTo: homeTeamLabel.leadingAnchor),
            startingPlayersLabel.topAnchor.constraint(equalTo: homeFormationLabel.bottomAnchor, constant: 30),
            
            // 주전 선수 스택 제약 조건
            homeStartingPlayersStack.leadingAnchor.constraint(equalTo: startingPlayersLabel.leadingAnchor),
            homeStartingPlayersStack.topAnchor.constraint(equalTo: startingPlayersLabel.bottomAnchor, constant: 4),
            
            awayStartingPlayersStack.trailingAnchor.constraint(equalTo: awayTeamLabel.trailingAnchor),
            awayStartingPlayersStack.topAnchor.constraint(equalTo: startingPlayersLabel.bottomAnchor, constant: 4),
            
            // 교체명단 레이블 제약 조건
            substitutesLabel.leadingAnchor.constraint(equalTo: homeTeamLabel.leadingAnchor),
            substitutesLabel.topAnchor.constraint(equalTo: homeStartingPlayersStack.bottomAnchor, constant: 35),
            
            // 교체 선수 스택 제약 조건
            homeSubstitutesStack.leadingAnchor.constraint(equalTo: substitutesLabel.leadingAnchor),
            homeSubstitutesStack.topAnchor.constraint(equalTo: substitutesLabel.bottomAnchor, constant: 4),
            homeSubstitutesStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            awaySubstitutesStack.trailingAnchor.constraint(equalTo: awayTeamLabel.trailingAnchor),
            awaySubstitutesStack.topAnchor.constraint(equalTo: substitutesLabel.bottomAnchor, constant: 4),
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
            
            // 선발 선수와 교체 선수들에게 각각 해당하는 레이팅을 전달
            configureStartingPlayers(homeLineup.startXI, in: homeStartingPlayersStack, fixture: fixture)
            configureSubstitutePlayers(homeLineup.substitutes, in: homeSubstitutesStack, fixture: fixture)
        }
    }
    
    private func configureAwayTeam(fixture: Fixture) {
        guard let awayTeam = fixture.teams?.away else { return }
        awayTeamLabel.text = awayTeam.name
        
        if let awayLineup = fixture.lineups?.first(where: { $0.team.id == awayTeam.id }) {
            awayCoachLabel.text = "Coach: \(awayLineup.coach.name ?? "No Data")"
            awayFormationLabel.text = "Formation: \(awayLineup.formation)"
            
            // 선발 선수와 교체 선수들에게 각각 해당하는 레이팅을 전달
            configureStartingPlayers(awayLineup.startXI, in: awayStartingPlayersStack, fixture: fixture)
            configureSubstitutePlayers(awayLineup.substitutes, in: awaySubstitutesStack, fixture: fixture)
        }
    }
    
    // 선발 선수 배열을 받아 라벨을 추가하는 메서드
    private func configureStartingPlayers(_ startingPlayers: [StartingPlayer]?, in stackView: UIStackView, fixture: Fixture) {
        guard let startingPlayers = startingPlayers else { return }
        
        // 홈팀과 어웨이팀의 선수 배열을 구별
        let homePlayers = fixture.players?.first(where: { $0.team.id == fixture.teams?.home?.id })?.players ?? []
        let awayPlayers = fixture.players?.first(where: { $0.team.id == fixture.teams?.away?.id })?.players ?? []
        
        for startingPlayer in startingPlayers {
            if let player = startingPlayer.player {
                // 홈팀인지 어웨이팀인지 구별하여 선수의 레이팅을 찾아옴
                var rating: String? = nil
                
                // 홈팀 선수를 찾을 경우
                if homePlayers.contains(where: { $0.player.id == player.id }) {
                    rating = homePlayers.first(where: { $0.player.id == player.id })?.statistics.first?.games.rating
                }
                // 어웨이팀 선수를 찾을 경우
                else if awayPlayers.contains(where: { $0.player.id == player.id }) {
                    rating = awayPlayers.first(where: { $0.player.id == player.id })?.statistics.first?.games.rating
                }
                
                let playerLabel = createPlayerLabel(with: player.name, position: player.pos, rating: rating)
                stackView.addArrangedSubview(playerLabel)
            }
        }
    }
    
    // 교체 선수 배열을 받아 라벨을 추가하는 메서드
    private func configureSubstitutePlayers(_ substitutes: [SubstitutePlayer], in stackView: UIStackView, fixture: Fixture) {
        // 홈팀과 어웨이팀의 선수 배열을 구별
        let homePlayers = fixture.players?.first(where: { $0.team.id == fixture.teams?.home?.id })?.players ?? []
        let awayPlayers = fixture.players?.first(where: { $0.team.id == fixture.teams?.away?.id })?.players ?? []
        
        for substitute in substitutes {
            if let player = substitute.player {
                // 홈팀인지 어웨이팀인지 구별하여 선수의 레이팅을 찾아옴
                var rating: String? = nil
                
                // 홈팀 선수를 찾을 경우
                if homePlayers.contains(where: { $0.player.id == player.id }) {
                    rating = homePlayers.first(where: { $0.player.id == player.id })?.statistics.first?.games.rating
                }
                // 어웨이팀 선수를 찾을 경우
                else if awayPlayers.contains(where: { $0.player.id == player.id }) {
                    rating = awayPlayers.first(where: { $0.player.id == player.id })?.statistics.first?.games.rating
                }
                
                let playerLabel = createPlayerLabel(with: player.name, position: player.pos, rating: rating)
                stackView.addArrangedSubview(playerLabel)
            }
        }
    }
    
    
    // 포지션에 맞는 이모지와 이름, 레이팅을 포함한 UILabel을 생성하는 메서드
    private func createPlayerLabel(with name: String?, position: String?, rating: String?) -> UILabel {
        let playerLabel = UILabel()
        playerLabel.font = UIFont.systemFont(ofSize: 14)
        
        let emoji = emojiForPosition(position)
        let playerName = name ?? "Unknown"
        
        // rating이 존재하면 텍스트에 포함하고, 없으면 그냥 이름만 표시
        if let rating = rating {
            playerLabel.text = "\(emoji) \(playerName)   \(rating)"
        } else {
            playerLabel.text = "\(emoji) \(playerName)"
        }
        
        return playerLabel
    }
    
    
}
