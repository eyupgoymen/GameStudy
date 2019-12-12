//
//  AttributedStrings.swift
//  GameStudy
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

extension String {
    func gameLabelAttributedString() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        
        let attributedText = NSMutableAttributedString(string: self, attributes: [
            NSAttributedString.Key.kern: 0.38,
            NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedText
    }
    
    func metacriticLabelAttributedString() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "metacritic: ", attributes: [
            NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 14, weight: .regular),
            NSAttributedString.Key.foregroundColor:  UIColor.black.cgColor
        ])
        
        attributedText.append(NSAttributedString(string: self, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor(hexString: "#d70000")
        ]))
        
        return attributedText
    }
}
