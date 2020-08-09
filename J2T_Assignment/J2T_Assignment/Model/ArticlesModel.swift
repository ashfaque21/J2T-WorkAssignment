//
//  ArticlesModel.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 05/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//

import Foundation


struct ArticleDictionary : Decodable {
    let articles : [ArticlesModel]
}

struct UserModel : Decodable {
    let id : String
    let blogId : String
    let createdAt : String
    let name : String
    let avatar : String
    let lastname : String
    let city : String
    let designation : String
    let about : String
}

struct MediaModel : Decodable {
    let id : String
    let blogId : String
    let createdAt : String
    let image : String
    let title : String
    let url : String
}

struct ArticlesModel : Decodable {
    let id : String?
    let createdAt : String?
    let content : String?
    let comments : Int
    let likes : Int
    let media : [MediaModel]
    let user : [UserModel]
}

