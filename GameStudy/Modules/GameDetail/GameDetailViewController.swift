//
//  GameDetailViewController.swift
//  GameStudy
//
//  Created Eyup Kazım Göymen on 12.12.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import UIKit

final class GameDetailViewController: LayoutingViewController {
    
    typealias ViewType = GameDetailView
    private let viewModel: GameDetailViewModel
    
    public required init(viewModel: GameDetailViewModel) {
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
        viewModel.fetchGameDetail()
        viewModel.checkIfGameFavorited()
    }
 
    private func setDelegates() {
        layoutableView.tableView.delegate = self
        layoutableView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //Setup bar button
        layoutableView.favoriteBarButton.target = self
        layoutableView.favoriteBarButton.action = #selector(favoriteBarButtonPressed)
        navigationItem.rightBarButtonItem = layoutableView.favoriteBarButton
    }
    
    @objc func favoriteBarButtonPressed() {
        viewModel.isInFavourites == true ? viewModel.removeFavorite() : viewModel.addFavorite()
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func handleViewModelOutput(_ output: GameDetailViewModelOutput) {
        switch output  {
            case .loading(let isLoading):
                layoutableView.setLoadingState(isLoading: isLoading)
           
            case .showError(let error):
                alert(message: error.localizedDescription)
               
            case .detailFetched(let gameDetail):
                DispatchQueue.main.async {
                    self.layoutableView.tableView.reloadData()
                    self.layoutableView.tableView.tableFooterView = UIView()
                }
                layoutableView.stretchyHeaderView.updateHeader(detail: gameDetail)
               
            case .favouriteStatusChanged:
                layoutableView.updateBarButtonConsideringFavoriteStatus(isInFavourites: viewModel.isInFavourites)
        }
    }
    
    func handleRouting(_ route: GameDetailRoute) {
        switch route {
            case .reddit(let url):
                guard let url = URL(string: url) else { return }
                UIApplication.shared.open(url)
            
            case .website(let url):
                guard let url = URL(string: url) else { return }
                UIApplication.shared.open(url)
        }
    }
}

extension GameDetailViewController: TableViewProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gameDetail == nil ? 0 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch DetailCellSections(section: indexPath.row) {
            case .description:
                let cell: GameDescriptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = viewModel.gameDetail?.description
                return cell
            
            case .reddit:
                let cell: GameSourceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = "Visit reddit"
                return cell
            
            case .website:
                let cell: GameSourceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.item = "Visit website"
                return cell
        
            default:
                fatalError("Unexpected cell index")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //Stretch affect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 291 - (scrollView.contentOffset.y + 291)
        let height = min(max(y, 0), 500)
        layoutableView.stretchyHeaderView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: UIScreen.main.bounds.size.width , height: height)
    }
}
