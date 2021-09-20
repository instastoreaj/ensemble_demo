//
//  CharacterDetailViewController.swift
//  Starwar_demo
//
//  Created by Mac on 9/20/21.
//

import UIKit

class CharacterDetailViewController: BaseViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CharacterDetailViewModel?
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
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
    }
    
    override func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        viewModel.dataSource.bind { [weak self] items in
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }
        
        viewModel.appState.bind{ [weak self] state in
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
        title = "Character Detail"
    }
    
    
    @objc private func refreshTableView(_ sender: Any) {
        viewModel?.fetchData()
    }
}
