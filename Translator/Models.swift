//
//  Models.swift
//  Translator
//
//  Created by Tianid on 06.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


struct TranslationParametrs: Encodable {
    let key: String
    let lang: String
    let text: String
}

struct TranslatedText {
    let lang: String
    let code: Int
    let text: String
    
    init?(json: [String: Any]) {
        self.lang = json["lang"] as! String
        self.code = json["code"] as! Int
        let textArray = json["text"] as! Array<String>
        self.text = textArray.first!
    }
}
