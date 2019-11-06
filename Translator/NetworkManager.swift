//
//  NetworkManager.swift
//  Translator
//
//  Created by Tianid on 06.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    init() {}
    
    
    func translateText(_ text: String, translateLanguage: TranslateLanguage, complitionhandler: @escaping ((String?) -> ()) ){
        let urlComponent = URLComponents(string: yandexTranslateAPIRequest)
        guard let url = urlComponent?.url else { return }
        let parameters = TranslationParametrs(key: yandexTranslateKey, lang: translateLanguage.rawValue, text: text)
        
        AF.request(url, method: .post, parameters: parameters).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let success):
                guard let json = success as? [String: Any] else { return }
                
                guard let translate = TranslatedText(json: json) else { return }
                complitionhandler(translate.text)
                
            case .failure(let error):
                print(error)
            }
            })
    }
}


