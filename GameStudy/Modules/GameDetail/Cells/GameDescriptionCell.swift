//
//  DescriptionCell.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class GameDescriptionCell: TableViewCell<String> {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Game Description"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(hexString: "313131")
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor(hexString: "313131")
        return label
    }()
        
    let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
    }()
        
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setupViews() {
        descriptionStackView.addArrangedSubviews(titleLabel, descriptionLabel)
        add(descriptionStackView)
    }
    
    override func setupLayout() {
        descriptionStackView.snp.makeConstraints {
            $0.top.leading.equalTo(16)
            $0.bottom.trailing.equalTo(-16)
        }
    }
    
    override func updateLayout(_ item: String?) {
        guard let item = item else { return }
        //Remove html tags as well
        self.descriptionLabel.attributedText = item.removeHTMLTags().descriptionLabelAttributedString()
    }
}

