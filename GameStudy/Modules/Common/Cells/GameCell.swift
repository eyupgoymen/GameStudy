//
//  GameCell.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit
import Kingfisher

final class GameCell: TableViewCell<Game> {
    
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let gameNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let genresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    let metacriticLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    
    let gameMetaDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.image = nil
        gameNameLabel.text = ""
        genresLabel.text = ""
        metacriticLabel.text = ""
        metacriticLabel.isHidden = false
    }
    
    override func setupViews() {
        gameMetaDataStackView.addArrangedSubviews(metacriticLabel, genresLabel)
        add(gameImageView, gameNameLabel, gameMetaDataStackView)
    }
    
    override func setupLayout() {
        gameImageView.snp.makeConstraints {
            $0.top.leading.equalTo(16)
            $0.bottom.equalTo(-16)
            $0.width.equalTo(120)
        }
        
        gameNameLabel.snp.makeConstraints {
            $0.top.equalTo(gameImageView)
            $0.leading.equalTo(gameImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(-16)
        }
        
        gameMetaDataStackView.snp.makeConstraints {
            $0.leading.equalTo(gameImageView.snp.trailing).offset(16)
            $0.bottom.equalTo(-12)
            $0.trailing.equalTo(16)
        }
    }
    
    override func updateLayout(_ item: Game?) {
        guard let item = item else { return }
        
        //Image url might be empty
        if let imageURL = item.backgroundImageUrl {
            gameImageView.kf.setImage(with: imageURL)
        }
        else {
            gameImageView.image = UIImage(named: "unavailable")
        }
        
        //metacritic might be empty
        if let metacritic = item.metacritic {
            metacriticLabel.attributedText = String(metacritic).metacriticLabelAttributedString()
        }
        else {
            metacriticLabel.isHidden = true
        }
        
        gameNameLabel.attributedText = item.name.gameLabelAttributedString()
        genresLabel.text = item.genres.map { $0.name }.joined(separator: ", ")
    }
}
