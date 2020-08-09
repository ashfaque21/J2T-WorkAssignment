//
//  ArticleViewModel.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 05/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//

import Foundation
import CoreData


protocol ArticleListViewModelDelegate: NSObject {
    func loadDataInTable()
    func showError(_ message: String)
}

class ArticleListViewModel : NSObject, NSFetchedResultsControllerDelegate {
    weak var modelDelegate : ArticleListViewModelDelegate?
    private var articles: Array<ArticlesModel>
    var pageNumber = 1
    var array: NSMutableArray?
    
    init(_ delegate: ArticleListViewModelDelegate?) {
           self.modelDelegate = delegate
           self.articles = Array<ArticlesModel>()
       }
}


extension ArticleListViewModel {
    var numberOfSection : Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section : Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index : Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
   
    func setup() {
               array = retrieveArticleData()
               NetworkManager().getArticles(pageNumber: pageNumber) { articles in
                   if let articles = articles {
                       if articles.count != 0 {
                           self.saveInCoreDataWith(array: articles)
                           self.array = self.retrieveArticleData()
                           DispatchQueue.main.async {
                            self.modelDelegate?.loadDataInTable()
                               self.pageNumber += 1
                           }
                       }
                       else {
                           //Show pop up to display error message
                            DispatchQueue.main.async {
                                self.modelDelegate?.showError("Looks like Data is not coming from server.")
                           }
                       }
                   }
               }
       }
       
   private func saveInCoreDataWith(array: [ArticlesModel] ) {
       _ = array.map { self.createArticleEntityFrom(array: $0) }
       do {
           try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
       } catch _ {
           //Display error.
       }
   }
   
   private func createArticleEntityFrom(array: ArticlesModel) -> NSManagedObject? {
       let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
       if let articleEntity = NSEntityDescription.insertNewObject(forEntityName: "Articles", into: context) as? Articles {
           articleEntity.comments = Int32(array.comments)
           articleEntity.content = array.content
           articleEntity.createdAt = array.createdAt
           articleEntity.id = array.id
           articleEntity.likes = Int32(array.likes)
           articleEntity.image = array.media.first?.image
           articleEntity.title = array.media.first?.title
           articleEntity.url = array.media.first?.url
           articleEntity.avatar = array.user.first?.avatar
           articleEntity.city = array.user.first?.city
           articleEntity.designation = array.user.first?.designation
           articleEntity.lastname = array.user.first?.lastname
           articleEntity.name = array.user.first?.name
           articleEntity.id = array.id
           return articleEntity
       }
       return nil
   }
    func retrieveArticleData() -> NSMutableArray? {

        //We need to create a context from this container
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.newBackgroundContext()

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Articles")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        let resultArr = NSMutableArray()
               
               do {
                   let result = try managedContext.fetch(fetchRequest)
                   for i in 0..<(result.count) {

                       let manageObj = result[i] as! NSManagedObject
                       
                       let keys = Array(manageObj.entity.attributesByName.keys)
                       let dict = manageObj.dictionaryWithValues(forKeys: keys)
                       resultArr.add(dict)
                   }
                   return resultArr
                   
               } catch {
                   return nil
               }
      }
}

struct ArticleViewModel {
    private var article : ArticlesModel
}

extension ArticleViewModel {
    init(_ article : ArticlesModel) {
        self.article = article
    }
}

extension ArticleViewModel {
        
        var content : String {
            return self.article.content!
        }
        
        var image : String {
            return self.article.media.first!.image
        }
        
        var title : String {
            return self.article.media.first!.title
        }
        
        var url : String? {
            return self.article.media.first!.url
        }
        
        var avatarImage : String {
            return self.article.user.first!.avatar
        }
        
        var name : String {
            return self.article.user.first!.name
        }
        
        var lastName : String {
            return self.article.user.first!.lastname
        }
        
        var designation : String {
            return self.article.user.first!.designation
        }
        
        var createdAt : String {
            return self.article.createdAt!
        }
    
        var comments : String {
            
            return String(self.article.comments)
        }
    
        var likes : String {
            return String(self.article.likes)
        }
    
        var contents : String {
            return self.article.content!
        }
}

