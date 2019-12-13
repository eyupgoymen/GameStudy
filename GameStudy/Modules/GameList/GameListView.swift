//
//  GameListView.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit
import SnapKit

final class GameListView: LayoutableView {
    
    //UI Objects
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GameCell.self)
        tableView.rowHeight = 136
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = UIColor(hexString: "E5E5E5")
        return tableView
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        return spinner
    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for the games"
        return searchController
    }()
    
    let emptyStateView: EmptyView = {
        let emptyView = EmptyView.create()
        emptyView.stateMessage = "No game has been searched"
        return emptyView
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
    
    //Show empty state if keyword is not appropriate
    func tableViewSearchState(keyword: String) {
        let keywordCharCount = keyword.trimmingCharacters(in: .whitespaces).lowercased().count
        
        if  keywordCharCount < 3 && keywordCharCount > 0 {
            self.tableView.backgroundView = self.emptyStateView
            self.tableView.separatorStyle = .none
            self.emptyStateView.center = self.tableView.center
            self.tableView.reloadData()
        }
        else {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = .singleLine
            self.tableView.tableFooterView = UIView()
            self.tableView.reloadData()
        }
    }
}
