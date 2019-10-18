//
//  VMBook.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/15.
//  Copyright © 2019年 retey. All rights reserved.
//
import CoreData
import Foundation
class VMBook:NSObject,DateViwModelDelegate{
    
    
     var id: UUID
     var author: String?
     var authorIntro: String?
     var categoryId: UUID?
     var image: String?
     var isban13: String?
     var isbn10: String?
     var pages: Int32?
     var price: String?
     var pubdate: String?
     var publisher: String?
     var summary: String?
     var title: String?
     var binding: String?
    
    override init() {
        id=UUID()
    }
    
    static let entityName = "book"
    static let colAuthor = "author"
    static let colAuthorIntro = "authorintro"
    static let colCategoryId = "categoryid"
    static let colId = "id"
    static let colImage = "image"
    static let colIsban13 = "isban13"
    static let colIsban10 = "isban10"
    static let colPages = "pages"
    static let colPrice = "price"
    static let colPubdate = "pubdate"
    static let colPublisher = "publisher"
    static let colSummary = "summary"
    static let colTitle = "title"
    static let colBinding = "binding"
    
    func entityPairs() -> Dictionary<String, Any?> {
        var dic:Dictionary<String,Any?> = Dictionary<String,Any?>()
        dic[VMBook.colId] = id
        dic[VMBook.colAuthor] = author
        dic[VMBook.colAuthorIntro] = authorIntro
        dic[VMBook.colCategoryId] = categoryId
        dic[VMBook.colImage] = image
        dic[VMBook.colIsban13] = isban13
        dic[VMBook.colIsban10] = isbn10
        dic[VMBook.colPages] = pages
        dic[VMBook.colPrice] = price
        dic[VMBook.colPubdate] = pubdate
        dic[VMBook.colPublisher] = publisher
        dic[VMBook.colSummary] = summary
        dic[VMBook.colTitle] = title
        dic[VMBook.colBinding] = binding
        return dic
    }
    
    func packageSelf(result: NSFetchRequestResult) {
        let book = result as! Book
        id = book.id!
        author = book.author
        authorIntro = book.authorIntro
        categoryId = book.categoryId
        image = book.image
        isbn10 = book.isbn10
        isban13 = book.isban13
        pages = book.pages
        price = book.price
        pubdate = book.pubdate
        publisher = book.publisher
        summary = book.summary
        title = book.title
        binding = book.binding
    }
   
}
