//
//  BookRepository.swift
//  DoubanBooks
//
//  Created by 2017yd on 2019/10/15.
//  Copyright © 2019年 retey. All rights reserved.
//

import Foundation
import CoreData
class BookRepository{
    var app: AppDelegate
    var context: NSManagedObjectContext
    
    init(_ app: AppDelegate) {
        self.app = app
     context = app.persistentContainer.viewContext
    }
    func isExists(_ isbn:String)throws-> Bool{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName:VMBook.entityName)
        fetch.predicate = NSPredicate(format:"\(VMBook.colIsban10) = %@||\(VMBook.colIsban13) = %@",isbn,isbn)
        do {
            let result = try context.fetch(fetch) as! [VMBook]
            return result.count > 0
        } catch  {
            throw DateError.entityExistsError("判断数据失败")
        }
    }
    
    func insert(vm: VMBook){
        let description = NSEntityDescription.entity(forEntityName: VMBook.entityName, in: context)
        let book = NSManagedObject(entity: description!, insertInto:context)
        book.setValue(vm.id, forKey: VMBook.colId)
        book.setValue(vm.author, forKey: VMBook.colAuthor)
        book.setValue(vm.image, forKey: VMBook.colImage)
        app.saveContext()
    }
    
    func get() throws -> [VMBook]{
        var books = [VMBook]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMBook.entityName)
        do {
            let result = try context.fetch(fetch) as! [VMBook]
            for c in result {
                let vm = VMBook()
                vm.id = c.id
                vm.author = c.author
                vm.image = c.image
                books.append(vm)
            }
        } catch {
            throw DateError.readCollectionError("读取集合数据失败")
        }
        
        return books
    }
    ///更新数据
    func update(_ vm:VMBook)throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMBook.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", vm.id.uuidString)
         do {
            let obj = try context.fetch(fetch)[0] as! NSManagedObject
            obj.setValue(vm.author, forKey: VMBook.colAuthor)
            obj.setValue(vm.authorIntro, forKey: VMBook.colAuthorIntro)
            obj.setValue(vm.price, forKey: VMBook.colPrice)
            obj.setValue(vm.image, forKey: VMBook.colImage)
            obj.setValue(vm.isbn10, forKey: VMBook.colIsban10)
            obj.setValue(vm.isban13, forKey: VMBook.colIsban13)
            obj.setValue(vm.pages, forKey: VMBook.colPages)
            obj.setValue(vm.pubdate, forKey: VMBook.colPubdate)
            obj.setValue(vm.binding, forKey: VMBook.colBinding)
            obj.setValue(vm.title, forKey: VMBook.colTitle)
            obj.setValue(vm.summary, forKey: VMBook.colSummary)
            obj.setValue(vm.categoryId, forKey: VMBook.colCategoryId)
            obj.setValue(vm.publisher, forKey: VMBook.colPublisher)
            app.saveContext()
        }catch{
            throw DateError.updateEntityError("更新图书失败")
        }
    }
  
    
    ///删除数据
    func delete(id: UUID) throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: VMBook.entityName)
        fetch.predicate = NSPredicate(format: "id = %@", id.uuidString)
        
        do{
            let result = try context.fetch(fetch)
            for b in result{
                context.delete(b as! NSManagedObject)
            }
            app.saveContext()
        }catch{
            throw DateError.deleteEntityError("删除图书馆失败")
        }
    }
}
