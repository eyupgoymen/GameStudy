//
//  GameListViewController.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class GameListViewController: LayoutingViewController {
    
    typealias ViewType = GameListView
    private let viewModel: GameListViewModel
    
    public required init(viewModel: GameListViewModel) {
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
        viewModel.fetchGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setDelegates() {
        layoutableView.tableView.delegate = self
        layoutableView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Setup search bar
        definesPresentationContext = true
        navigationItem.searchController = layoutableView.searchController
        layoutableView.searchController.searchResultsUpdater = self
        layoutableView.searchController.searchBar.delegate = self
        
        //Set tabbar when pushed
        hidesBottomBarWhenPushed = true
    }
}

extension GameListViewController: GameListViewModelDelegate {
    func handleViewModelOutput(_ output: GameListViewModelOutput) {
        switch  output{
            case .loading(let isLoading):
                layoutableView.setLoadingState(isLoading: isLoading)
        
            case .showError(let error):
                //Do not show error in case that end of pages
                guard case NetworkError.endOfPages = error else { return }
                alert(message: error.localizedDescription)
            
            case .gamesFetched:
                DispatchQueue.main.async {
                    self.layoutableView.tableView.reloadData()
                }
            
            case .searchedGamesFetched:
                DispatchQueue.main.async {
                    self.layoutableView.tableView.reloadData()
            }
        }
    }
    
    //TODO: implement routing
    func handleRouting(_ route: GameListRoute) {
        switch route {
            case .gameDetail(let game):
                let detailModule = GameDetailBuilder.create(game: game)
                navigationController?.pushViewController(detailModule, animated: true)
            }
    }
}

extension GameListViewController: TableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isSearchingGame ? viewModel.searchedGames.count : viewModel.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let row = indexPath.row
        cell.item = viewModel.isSearchingGame ? viewModel.searchedGames[row] : viewModel.games[row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        //Do not allow to press empty cells
        if viewModel.isSearchingGame, row < viewModel.searchedGames.count {
            viewModel.navigateToGameDetail(at: row)
        }
            
        else if !viewModel.isSearchingGame, row < viewModel.games.count{
            viewModel.navigateToGameDetail(at: row)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isSearchingGame, indexPath.row == viewModel.searchedGames.count - 1 {
            viewModel.search(keyword: viewModel.searchKeyword)
        }
        
        if !viewModel.isSearchingGame, indexPath.row == viewModel.games.count - 1 {
            viewModel.fetchGames()
        }
    }
}

//Delegate to handle search bar activities
extension GameListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text else { return }
        viewModel.resetSearchResults()
        viewModel.search(keyword: text)
        
        //Update tableView for search results - not found
        layoutableView.tableViewSearchState(keyword: text)
    }
    
    //Reload state if cancel button clicked in search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchKeyword = ""
        
        //disable tableView background view
        layoutableView.tableViewSearchState(keyword: "clicked")
    }
}
