//
//  GameDetailView.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit
import SnapKit

final class GameDetailView: LayoutableView {
    
    //UI Objects
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GameCell.self)
        tableView.allowsSelection = false
        tableView.register(GameDescriptionCell.self)
        tableView.register(GameSourceCell.self)
        tableView.contentInset = UIEdgeInsets(top: 291, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        return spinner
    }()
    
    lazy var stretchyHeaderView: StretchyHeaderView = {
        let stretchyHeaderView = StretchyHeaderView.create()
        stretchyHeaderView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 291)
        tableView.addSubview(stretchyHeaderView)
        return stretchyHeaderView
    }()
    
    let favoriteBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Favorite", style: .plain, target: nil, action: nil)
        barButton.isEnabled = false
        return barButton
    }()
    
    func setupViews() {
        backgroundColor = .white
        add(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin)
            $0.bottomMargin.equalTo(self.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
    
    func setLoadingState(isLoading: Bool) {
        self.tableView.tableFooterView?.isHidden = !isLoading
    }
    
    func updateBarButtonConsideringFavoriteStatus(isInFavourites: Bool) {
        favoriteBarButton.isEnabled = true
        favoriteBarButton.title = isInFavourites == true ? "Favorite" : "Add Favorites"
    }
}
