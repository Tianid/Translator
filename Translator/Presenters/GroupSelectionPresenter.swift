//
//  GroupSelectionPresenter.swift
//  Translator
//
//  Created by Tianid on 19.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation
import CoreData

class GroupSelectionPresenter: GroupSelectionPresenterProtocol {
    
    
    func saveTranslatedTextIntoSelectedGroups(selectedGroups: [Int], context: NSManagedObjectContext, translation: (english: String, russian: String)) {
        ModelManager.shared.saveTranslateIntoGroups(context: context, selectedGroups: selectedGroups, translation: translation)
    }
    
    var groupSelectionViewController: GroupSelectionProtocol?
    
    
    
    
    
    
}
