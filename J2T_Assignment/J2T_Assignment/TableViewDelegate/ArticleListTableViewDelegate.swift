//
//  ArticleListTableViewDelegate.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 06/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//

import Foundation
import UIKit

class ArticleListTableViewDelegate : NSObject, UITableViewDelegate {
    
    let articleListViewModel: ArticleListViewModel
          
    init(_ articleListViewModel: ArticleListViewModel) {
            self.articleListViewModel = articleListViewModel
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.loadingForNextPage(indexPath) {
            self.articleListViewModel.setup()
            tableView.stopLoading()
        }
    }
}
