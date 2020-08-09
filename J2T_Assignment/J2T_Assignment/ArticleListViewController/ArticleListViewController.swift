//
//  ArticleListViewController.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 05/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ArticleListViewController: UITableViewController {
    private var articleListVM : ArticleListViewModel!
    var tableViewDatasource: ArticleListTableDataSource!
    var tableViewDelegate : ArticleListTableViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articleListVM = ArticleListViewModel(self)
        self.tableViewDatasource = ArticleListTableDataSource(self.articleListVM)
        self.tableViewDelegate = ArticleListTableViewDelegate(self.articleListVM)
        self.tableView.dataSource = self.tableViewDatasource
        self.tableView.delegate = self.tableViewDelegate
        self.articleListVM.setup()
    }
}


extension ArticleListViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            if indexPath == nil {
                self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
            }
            else {
                self.tableView.insertRows(at: [indexPath!], with: .automatic)
            }
        default:
            break
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
}

extension ArticleListViewController : ArticleListViewModelDelegate {
    func loadDataInTable() {
          self.tableView.reloadData()
    }
    
    func showError(_ message: String) {
        self.showErrorWith("Alert Message", message: message)
        self.tableView.stopLoading()
        self.tableView.endUpdates()
    }
    
    
}
