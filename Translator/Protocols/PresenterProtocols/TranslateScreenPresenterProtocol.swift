
//
//  TranslateScreenPresenterProtocol.swift
//  Translator
//
//  Created by Tianid on 06.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

protocol TranslateScreenPresenterProtocol {
    var translateScreenViewController: TranslateScreenProtocol? { get set }
    func getTranslate(text: String, translateLanguageType: TranslateLanguage)
}
