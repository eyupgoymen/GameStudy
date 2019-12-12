//
//  LayoutableView.swift
//  GameStudyProd
//
//  Created by Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

typealias LayoutableView = UIView & Layoutable

public protocol Layoutable: AnyObject {
    func setupViews()
    func setupLayout()
    var screenBounds: CGRect { get }
}

public extension Layoutable where Self: UIView {
    var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    static func create(setupViews: Bool = true, setupLayout: Bool = true) -> Self {
        let view = Self()
        if setupViews  {  view.setupViews()  }
        if setupLayout {  view.setupLayout() }
        return view
    }
}
