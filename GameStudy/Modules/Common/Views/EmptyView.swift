//
//  EmptyView.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit
import SnapKit

final class EmptyView: LayoutableView {
    
    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.text = "Hii"
        return label
    }()
    
    var stateMessage: String = "Search Result" {
        didSet {
            emptyStateLabel.text = stateMessage
        }
    }
    
    func setupViews() {
        backgroundColor = UIColor(hexString: "E5E5E5")
        add(emptyStateLabel)
    }
    
    func setupLayout() {
        emptyStateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(48)
        }
    }
}
