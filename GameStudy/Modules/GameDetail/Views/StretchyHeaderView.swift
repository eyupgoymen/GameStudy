//
//  StretchyHeaderView.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class StretchyHeaderView: LayoutableView {
    
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private var gradientView = UIView()
    
    func setupViews() {
        add(gameImageView, gradientView, gameNameLabel)
        
        DispatchQueue.main.async {
            self.gradientView.setGradient(colors:
                                          UIColor.white.withAlphaComponent(0),
                                          UIColor.black.withAlphaComponent(0.8),
                                          direction: .vertical)
        }
    }
    
    func setupLayout() {
        gameImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(192)
            $0.bottom.equalTo(gameImageView)
            $0.centerX.equalToSuperview()
        }
        
        gameNameLabel.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.bottom.equalTo(-16)
        }
    }
    
    func updateHeader(detail: GameDetailResponse) {
        //Set image
        if let imageURL = detail.backgroundImage {
            gameImageView.kf.setImage(with: imageURL)
        }
        else {
            gameImageView.image = UIImage(named: "unavailable")
        }
        
        //Set name
        gameNameLabel.text = detail.name
    }
}



