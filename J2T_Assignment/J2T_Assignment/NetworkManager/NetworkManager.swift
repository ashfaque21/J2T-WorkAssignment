//
//  NetworkManager.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 05/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//

import Foundation

class NetworkManager {
    func getArticles(pageNumber : Int, completion :@escaping ([ArticlesModel]?) -> ())  {
        let urlString = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=\(pageNumber)&limit=10"
         let url : URL = URL(string: urlString)!
       
        URLSession.shared.dataTask(with: url) {data, response, error in
            if error != nil {
            }
            else if let data = data {
                let articles = try? JSONDecoder().decode(Array<ArticlesModel>.self, from: data)
                if let articleData = articles {
                    completion(articleData)
                }
              }
        }.resume()
    }
 }
