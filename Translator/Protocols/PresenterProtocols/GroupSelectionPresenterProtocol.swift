//
//  GroupSelectionPresenterProtocol.swift
//  Translator
//
//  Created by Tianid on 19.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation
import CoreData

protocol GroupSelectionPresenterProtocol {
    var groupSelectionViewController: GroupSelectionProtocol? { get set }
    func saveTranslatedTextIntoSelectedGroups(selectedGroups: [Int], context: NSManagedObjectContext, translation: (english: String, russian: String))
}
