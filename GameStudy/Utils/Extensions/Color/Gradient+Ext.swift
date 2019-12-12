//
//  Gradient+Ext.swift
//  GameStudyProd
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

extension UIView {
    enum GradientDirection {
        case vertical
        case horizantal
    }
    
    func setGradient(colors: UIColor..., direction: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.colors = colors.map { return $0.cgColor}
        
        switch direction {
            case .vertical:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            case .horizantal:
                gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
