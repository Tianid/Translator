//
//  Constants.swift
//  Translator
//
//  Created by Tianid on 06.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

public let yandexTranslateAPIRequest = "https://translate.yandex.net/api/v1.5/tr.json/translate"
public let yandexTranslateKey = "trnsl.1.1.20191105T114611Z.ce6720e0e4ab3402.8c9f7c395ac7d1f08946da4db1588e495e05199b"


enum TranslateLanguage: String {
    case fromEnToRu = "en-ru"
    case fromRuToEn = "ru-en"
}




