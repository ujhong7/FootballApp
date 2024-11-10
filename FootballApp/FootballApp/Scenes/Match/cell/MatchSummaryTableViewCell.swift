//
//  MatchSummaryTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/28/24.
//

import UIKit

class MatchSummaryTableViewCell: UITableViewCell {
    
    static let identifier = "MatchSummaryTableViewCell"
    
    // MARK: - UI Elements
    private let refereeLabel = UILabel()
    private let dateLabel = UILabel()
    private let venueLabel = UILabel()
    private let leagueLabel = UILabel()
    private let eventsStackView = UIStackView()
    private let separatorView = UIView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupUI() {
        refereeLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        venueLabel.font = UIFont.systemFont(ofSize: 15)
        leagueLabel.font = UIFont.systemFont(ofSize: 15)
        
        refereeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        venueLabel.translatesAutoresizingMaskIntoConstraints = false
        leagueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        eventsStackView.axis = .vertical
        eventsStackView.spacing = 4
        eventsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .lightGray
        
        contentView.addSubview(refereeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(venueLabel)
        contentView.addSubview(leagueLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(eventsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leagueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            leagueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            leagueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            refereeLabel.topAnchor.constraint(equalTo: leagueLabel.bottomAnchor, constant: 5),
            refereeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            refereeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dateLabel.topAnchor.constraint(equalTo: refereeLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            venueLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            venueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            venueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            separatorView.topAnchor.constraint(equalTo: venueLabel.bottomAnchor, constant: 10),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            eventsStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            eventsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            eventsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            eventsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Cell Configuration
    func configure(with fixture: Fixture) {
        configureBasicInfo(with: fixture)
        configureEvents(with: fixture.events, homeTeam: fixture.teams?.home?.name, awayTeam: fixture.teams?.away?.name)
    }

    // 기본 정보 구성 (심판, 날짜, 경기장, 리그)
    private func configureBasicInfo(with fixture: Fixture) {
        refereeLabel.text = "심판: \(fixture.fixture.referee ?? "Unknown Referee")"
        
        guard let date = Date.fromISO8601(fixture.fixture.date) else {
            dateLabel.text = "날짜: 알 수 없음"
            return
        }
        dateLabel.text = "날짜: \(date.toKoreanDateString())"
        
        venueLabel.text = "경기장: \(fixture.fixture.venue?.name ?? "Unknown Venue")"
        leagueLabel.text = "\(fixture.league.name) \(fixture.league.season) \(fixture.league.round)"
    }

    // 이벤트 구성
    private func configureEvents(with events: [Event]?, homeTeam: String?, awayTeam: String?) {
        // 이전 이벤트 제거
        eventsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard let events = events, !events.isEmpty else {
            addNoEventsLabel()
            return
        }
        
        // 이벤트를 시간 순으로 정렬하여 표시
        let sortedEvents = events.sorted { $0.time.elapsed < $1.time.elapsed }
        for event in sortedEvents {
            let eventDescription = getEventDescription(for: event)
            let eventStack = createEventStack(for: eventDescription, teamName: event.team.name, homeTeam: homeTeam, awayTeam: awayTeam)
            
            eventsStackView.addArrangedSubview(eventStack)
        }
    }

    // 이벤트 설명 생성
    private func getEventDescription(for event: Event) -> String {
        let eventTime = event.time.elapsed
        let eventPlayer = event.player.name ?? "Unknown Player"
        var eventDescription = ""
        
        switch event.type.lowercased() {
        case "goal":
            let assistPlayer = event.assist?.name ?? "No Assist"
            eventDescription = "\(eventTime)' ⚽️ \(eventPlayer) \n      (assist: \(assistPlayer))"
        case "card":
            let cardEmoji = event.detail == "Yellow Card" ? "🟨" : (event.detail == "Red Card" ? "🟥" : "❓")
            eventDescription = "\(eventTime)' \(cardEmoji) \(eventPlayer)"
        case "subst":
            let assistPlayer = event.assist?.name ?? "Unknown Substitute"
            eventDescription = "\(eventTime)' \(assistPlayer) \n      ➡️ \(eventPlayer)"
        case "foul":
            eventDescription = "\(eventTime)' 🛑 Foul \(eventPlayer)"
        case "penalty":
            eventDescription = "\(eventTime)' 🥅 Penalty \(event.detail) \(eventPlayer)"
        default:
            eventDescription = "\(eventTime)' ⚠️ \(event.detail) \(eventPlayer)"
        }
        
        return eventDescription
    }

    // 이벤트 스택 생성
    private func createEventStack(for eventDescription: String, teamName: String, homeTeam: String?, awayTeam: String?) -> UIStackView {
        let eventLabel = UILabel()
        eventLabel.font = UIFont.systemFont(ofSize: 14)
        eventLabel.text = eventDescription
        eventLabel.numberOfLines = 2
        
        let eventStack = UIStackView()
        eventStack.axis = .horizontal
        eventStack.distribution = .fillEqually
        
        if teamName == homeTeam {
            eventStack.addArrangedSubview(eventLabel)
            eventStack.addArrangedSubview(UILabel()) // 빈 라벨로 오른쪽 공간 확보
        } else if teamName == awayTeam {
            eventStack.addArrangedSubview(UILabel()) // 빈 라벨로 왼쪽 공간 확보
            eventStack.addArrangedSubview(eventLabel)
        }
        
        return eventStack
    }

    // 이벤트가 없을 때 라벨 추가
    private func addNoEventsLabel() {
        let noEventsLabel = UILabel()
        noEventsLabel.text = "경기가 아직 진행되지 않았습니다."
        eventsStackView.addArrangedSubview(noEventsLabel)
    }
    
}
