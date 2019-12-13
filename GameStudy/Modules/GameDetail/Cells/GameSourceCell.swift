//
//  GameDirectionCell.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class GameSourceCell: TableViewCell<String> {
    
    let sourceTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Game Description"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(hexString: "313131")
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setupViews() {
        selectionStyle = .none
        add(sourceTitle)
    }
    
    override func setupLayout() {
        sourceTitle.snp.makeConstraints {
            $0.top.leading.equalTo(16)
            $0.bottom.trailing.equalTo(-16)
        }
    }
    
    override func updateLayout(_ item: String?) {
        guard let item = item else { return }
        self.sourceTitle.text = item
    }
}
