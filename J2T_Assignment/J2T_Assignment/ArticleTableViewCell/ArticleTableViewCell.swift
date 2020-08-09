//
//  ArticleTableViewCell.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 05/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var articleContentLabel: UILabel!
    
    @IBOutlet weak var articleCommentsLabel: UILabel!
    @IBOutlet weak var articleLikesLabel: UILabel!
    @IBOutlet weak var articleURLLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
   
   
    func setArticleWith(article: NSDictionary?) {

        DispatchQueue.main.async {
            
            //Display Title
            self.articleTitleLabel.text = article!["title"] as? String ?? ""
            //Display Name & Last Name
            self.userNameLabel.text = (article!["name"] as? String ?? "") + " " + (article!["lastname"] as? String ?? "")
            //Display Designation
            self.userDesignationLabel.text = article!["designation"] as? String ?? ""
            //Display URL
            self.articleURLLabel.text = article!["url"] as? String ?? ""
            //Display Comments & Likes on screen
            if let number = article!["comments"], let likes = article!["likes"]
            {
                let commentsCount : Float = (number as! Float / 1000)
                let likesCount : Float = (likes as! Float / 1000)
                self.articleCommentsLabel.text = String(format: "%.2f", commentsCount ) + "K" + " comments"
                self.articleLikesLabel.text = String(format: "%.2f", likesCount) + "K"  + " likes"
            }
            //Display Content on screen
            self.articleContentLabel.text = article!["content"] as? String ?? ""
            //Show Main image
            if let url = article!["image"] as? String {
                self.articleImageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "No_Image_Found.png"))
            }
            else {
                self.articleImageView.image = UIImage(named : "No_Image_Found.png")
            }
            //Show Avatar Image
            if let url = article!["avatar"] as? String {
                self.avatarImageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "No_Image_Found.png"))
            }

            //Time mapping to label
            let retrieveDate = article!["createdAt"] as? String ?? ""
            if let date = Date().getDate(retrieveDate) {
                let months = Date().getNumberOfMonths(date: date)
                 self.timeLabel.text = months
            }
        }

    }
}
