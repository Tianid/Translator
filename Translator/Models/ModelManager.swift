//
//  ModelManager.swift
//  Translator
//
//  Created by Tianid on 18.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation
import CoreData


class ModelManager {
    static let shared = ModelManager()
    
    var groupsArray = [GroupModel]()
    
    
    func checkGeneralGroup(appDelegate: AppDelegate) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Groups>(entityName: "Groups")
        fetchRequest.predicate = NSPredicate(format: "groupName = %@", "General")
        do {
            let result = try managedContext.fetch(fetchRequest)
            let data = result as [Groups]
            guard data.count == 0 else { return }
            // create general group
            createGeneralGroup(context: managedContext)
            print(data)
        } catch {
            print(error)
        }
    }
    
    private func createGeneralGroup(context: NSManagedObjectContext) {
        let group = Groups(context: context)
        group.groupName = "General"
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //    func createBasicGroup(context: NSManagedObjectContext) {
    //        let group = Groups(context: context)
    //        group.groupName = "Basic"
    //        do {
    //            try context.save()
    //        } catch let error as NSError {
    //            print("Could not save. \(error), \(error.userInfo)")
    //        }
    //    }
    
    func fetchAllGroups(appDelegate: AppDelegate) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Groups>(entityName: "Groups")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as [Groups]
            
            for element in result {
                
                let group = GroupModel(groupName: element.groupName!)
                if let translationsCoreDataModel = element.translate?.allObjects as? [Translate], !translationsCoreDataModel.isEmpty {
                    for translate in translationsCoreDataModel  {
                        let english = translate.english!
                        let russian = translate.russian!
                        group.translations.append(TranslationModel(english: english, russian: russian))
                    }
                }
                
                ModelManager.shared.groupsArray.append(group)
            }
        } catch {
            print("failed")
        }
    }
    
    func saveTranslateIntoGroups(context: NSManagedObjectContext, selectedGroups: [Int], translation: (english: String, russian: String)) {
        let subPredicates = prepareGroups(selectedGroups: selectedGroups)
        
        
        let fetchRequest = NSFetchRequest<Groups>.init(entityName: "Groups")
        fetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: subPredicates)
        
        
        
        do {
            let result = try context.fetch(fetchRequest)
            for group in result as [Groups] {
                
                let translate = Translate(context: context)
                
                translate.english = translation.english
                translate.russian = translation.russian
                group.addToTranslate(translate)
                
            }
            try context.save()
            updateModelForViews(selectedGroups: selectedGroups, translation: translation)
            
        } catch {
            print("failed")
        }
        
    }
    
    private func prepareGroups(selectedGroups: [Int]) -> [NSPredicate] {
        var subPredicates : [NSPredicate] = []
        for element in selectedGroups {
            subPredicates.append(NSPredicate(format: "groupName = %@", groupsArray[element].groupName))
        }
        return subPredicates
    }
    
    private func updateModelForViews(selectedGroups: [Int], translation: (english: String, russian: String)) {
        
        let translationModel = TranslationModel(english: translation.english, russian: translation.russian)
        
        for element in selectedGroups {
            ModelManager.shared.groupsArray[element].translations.append(translationModel)
        }
    }
    
    func createCustomGroup(name: String, context: NSManagedObjectContext) {
        let group = Groups(context: context)
        group.groupName = name
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

