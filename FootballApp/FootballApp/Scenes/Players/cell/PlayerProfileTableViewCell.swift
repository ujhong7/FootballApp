//
//  PlayerProfileTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/22/24.
//

import UIKit

class PlayerProfileTableViewCell: UITableViewCell {
    
    static let identifier = "PlayerProfileTableViewCell"
    
    private let countryLabel = UILabel()
    private let ageLabel = UILabel()
    private let birthYearLabel = UILabel()
    private let birthPlaceLabel = UILabel()
    private let heightLabel = UILabel()
    private let weightLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        countryLabel.font = UIFont.systemFont(ofSize: 16)
        ageLabel.font = UIFont.systemFont(ofSize: 16)
        birthYearLabel.font = UIFont.systemFont(ofSize: 16)
        birthPlaceLabel.font = UIFont.systemFont(ofSize: 16)
        heightLabel.font = UIFont.systemFont(ofSize: 16)
        weightLabel.font = UIFont.systemFont(ofSize: 16)
        
        // UILabel들을 셀에 추가
        contentView.addSubview(countryLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(birthYearLabel)
        contentView.addSubview(birthPlaceLabel)
        contentView.addSubview(heightLabel)
        contentView.addSubview(weightLabel)
    }
    
    private func setupConstraints() {
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        birthYearLabel.translatesAutoresizingMaskIntoConstraints = false
        birthPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 국가 레이블
            countryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            // 나이 레이블
            ageLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10),
            ageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            // 출생년도 레이블
            birthYearLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            birthYearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            // 출생지역 레이블
            birthPlaceLabel.topAnchor.constraint(equalTo: birthYearLabel.bottomAnchor, constant: 10),
            birthPlaceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            // 키 레이블
            heightLabel.topAnchor.constraint(equalTo: birthPlaceLabel.bottomAnchor, constant: 10),
            heightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            // 몸무게 레이블
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            weightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    //    // 데이터 설정 메서드
    //    func configure(with playerResponse: PlayerResponse) {
    //        countryLabel.text = "국적: \(playerResponse.player.nationality)"
    //        ageLabel.text = "나이: \(playerResponse.player.age)"
    //        birthYearLabel.text = "출생년도: \(playerResponse.player.birth?.date)"
    //        birthPlaceLabel.text = "출생지역: \(playerResponse.player.birth?.place)"
    //        heightLabel.text = "키: \(playerResponse.player.height)"
    //        weightLabel.text = "몸무게: \(playerResponse.player.weight)"
    //    }
    
    // 데이터 설정 메서드
    func configure(with playerResponse: PlayerResponse) {
        guard let nationality = playerResponse.player.nationality,
              let age = playerResponse.player.age,
              let birthDate = playerResponse.player.birth?.date,
              let birthPlace = playerResponse.player.birth?.place,
              let height = playerResponse.player.height,
              let weight = playerResponse.player.weight else {
            // 값이 없는 경우 처리할 로직
            print("필수 데이터가 없습니다.")
            return
        }
        
        // 모든 값이 안전하게 언래핑된 이후 UI 업데이트
        countryLabel.text = "국적: \(nationality)"
        ageLabel.text = "나이: \(age)"
        birthYearLabel.text = "출생년도: \(birthDate)"
        birthPlaceLabel.text = "출생지역: \(birthPlace)"
        heightLabel.text = "키: \(height)"
        weightLabel.text = "몸무게: \(weight)"
    }
    
}

