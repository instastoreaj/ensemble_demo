//
//  FilmsViewController.swift
//  Starwar_demo
//
//  Created by Mac on 9/16/21.
//

import UIKit

class FilmsViewController: BaseViewController, Storyboarded {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = {
        FilmsViewModel()
    }()
    
    private var dataSource: TableViewDataSource!
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupComponents() {
        super.setupComponents()
        dataSource = TableViewDataSource(delegate: viewModel, view: self)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(FilmViewCell.self)
        searchBar.delegate = self
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
    }
    
    override func bindViewModel() {
        viewModel.dataSource.bind { [weak self] _ in
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }
        viewModel.appState.bind { [weak self] state in
            switch state {
            case .loading:
                self?.startIndicatingActivity()
            case .stop:
                self?.stopIndicatingActivity()
            case .error(let error):
                self?.stopIndicatingActivity()
                AppAlert().show(to: self!, title: "Error", message: "\(error)")
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.fetchData()
    }
    
    override func updateUI() {
        title = "Films"
    }
    
    @objc private func refreshTableView(_ sender: Any) {
        viewModel.fetchData()
    }
}

extension FilmsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(text: searchBar.text ?? "")
    }
}

