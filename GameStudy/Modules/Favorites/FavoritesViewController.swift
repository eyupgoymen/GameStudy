//
//  FavoritesViewController.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 13.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class FavoritesViewController: LayoutingViewController {
    
    typealias ViewType = FavoritesView
    private let viewModel: FavoritesViewModel
    
    public required init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = ViewType.create()
    }
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchGames()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setDelegates() {
        layoutableView.tableView.delegate = self
        layoutableView.tableView.dataSource = self
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func handleViewModelOutput(_ output: FavoritesViewModelOutput) {
        switch  output{
            case .loading(let isLoading):
                layoutableView.setLoadingState(isLoading: isLoading)
                
            case .showError(let error):
                alert(message: error.localizedDescription)
                
            case .gamesFetched:
                //Update background view of table view for empty case
                layoutableView.tableViewEmptyState(isEmpty: viewModel.games.count == 0 ? true : false)
                
                DispatchQueue.main.async {
                    self.layoutableView.tableView.reloadData()
                }
                
            case .removedFavorite(let index):
                layoutableView.removeFavoriteCell(at: index)
                layoutableView.tableViewEmptyState(isEmpty: viewModel.games.count == 0 ? true : false)
                
        }
    }
}

extension FavoritesViewController: TableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.item = viewModel.games[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeFavorite(at: indexPath.row)
        }
    }
}
