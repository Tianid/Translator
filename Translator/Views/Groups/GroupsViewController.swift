//
//  GroupDetailViewController.swift
//  Translator
//
//  Created by Tianid on 19.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    private var tableView: UITableView!
    private var reusableCellId = "CellID"
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        createNewGroup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    private func setup() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        // reusable cell register
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    
    
    private func createNewGroup() {
        let alert = UIAlertController(title: nil, message: "Call new group", preferredStyle: .alert)
        
        //        let textField = UITextField()
        alert.addTextField { (textField) in }
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert ](_) in
            let textFieldText = alert?.textFields![0].text
            let group = GroupModel(groupName: textFieldText!)
            ModelManager.shared.groupsArray.append(group)
            let indexPath = IndexPath(item: ModelManager.shared.groupsArray.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            ModelManager.shared.createCustomGroup(name: textFieldText!, context: context!)
        }))
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
}

extension GroupsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManager.shared.groupsArray.count
        //        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let count = ModelManager.shared.groupsArray[indexPath.row].translations.count
        cell.textLabel?.text = ModelManager.shared.groupsArray[indexPath.row].groupName
        cell.detailTextLabel?.text = String(count ?? 0)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
