//
//  TranslateScreenPresenter.swift
//  Translator
//
//  Created by Tianid on 06.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

class TranslateScreenPresenter: TranslateScreenPresenterProtocol {
    
    
    weak var translateScreenViewController: TranslateScreenProtocol?
    
    func getTranslate(text: String, translateLanguageType: TranslateLanguage) {
        NetworkManager.shared.translateText(text, translateLanguage: translateLanguageType) { [weak self] (text) in
            guard let text = text else { return }
            self?.translateScreenViewController?.setupTranslateTextView(text)
        }
    }
}
