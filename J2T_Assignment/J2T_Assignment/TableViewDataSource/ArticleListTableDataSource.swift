//
//  ArticleListTableDataSource.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 06/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//


import UIKit

class ArticleListTableDataSource: NSObject, UITableViewDataSource {
    
    let articleListViewModel: ArticleListViewModel
       
    init(_ articleListViewModel: ArticleListViewModel) {
        self.articleListViewModel = articleListViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel.array!.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
                    fatalError("ArticleTableViewCell not found.")
                }
        let article = self.articleListViewModel.array![indexPath.row] as? NSDictionary
        articleCell.setArticleWith(article: article)
           
        return articleCell
    }
}

