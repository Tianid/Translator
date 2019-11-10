//
//  SavedTranslationsViewController.swift
//  Translator
//
//  Created by Tianid on 07.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class SavedTranslationsViewController: UIViewController {
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        print(#function)
        // Do any additional setup after loading the view.
    }
    
    
    private func setup() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
    }

}
