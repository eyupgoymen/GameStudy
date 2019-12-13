//
//  FavoritesView.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit
import SnapKit

final class FavoritesView: LayoutableView {
    
    //UI Objects
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GameCell.self)
        return tableView
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        return spinner
    }()
    
    let emptyStateView: EmptyView = {
        let emptyView = EmptyView.create()
        emptyView.stateMessage = "There is no favorite found."
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
    
    func tableViewEmptyState(isEmpty: Bool) {
        if isEmpty {
            tableView.beginUpdates()
            self.tableView.backgroundView = self.emptyStateView
            self.tableView.separatorStyle = .none
            self.emptyStateView.center = self.tableView.center
            tableView.endUpdates()
        }
        else {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        }
    }
    
    func removeFavoriteCell(at index: Int) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        tableView.endUpdates()
    }
}
