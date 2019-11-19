//
//  GroupModel.swift
//  Translator
//
//  Created by Tianid on 19.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


class GroupModel {
    
    var groupName: String
    var translations: [TranslationModel] = []
    
    init(groupName: String) {
        self.groupName = groupName
    }
    
}
