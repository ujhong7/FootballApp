//
//  TeamInformationTableViewCell.swift
//  FootballApp
//
//  Created by yujaehong on 10/19/24.
//

import UIKit

class TeamInformationTableViewCell: UITableViewCell {
    
    static let identifier = "TeamInformationTableViewCell"
    
    let stadiumLabel: UILabel = {
        let label = UILabel()
        label.text = "OT"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Manchester"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let capacityLabel: UILabel = {
        let label = UILabel()
        label.text = "76212"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Sir Matt Busby Way"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stadiumImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [stadiumLabel, cityLabel, capacityLabel, addressLabel, stadiumImageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stadiumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stadiumImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stadiumImageView.widthAnchor.constraint(equalToConstant: 100),  // 너비 조정
            stadiumImageView.heightAnchor.constraint(equalToConstant: 100), // 높이 조정
            
            stadiumLabel.topAnchor.constraint(equalTo: stadiumImageView.bottomAnchor, constant: 10),
            stadiumLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: stadiumLabel.bottomAnchor, constant: 5),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            capacityLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            capacityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: capacityLabel.bottomAnchor, constant: 5),
            addressLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    
    func configure(with teamDetail: TeamDetail) {
        stadiumLabel.text = teamDetail.venue.name
        cityLabel.text = teamDetail.venue.city
        capacityLabel.text = "\(teamDetail.venue.capacity!)"
        addressLabel.text = teamDetail.venue.address
        stadiumImageView.loadImage(from: teamDetail.venue.image)
    }
    
}
