//
//  GroupSelectionViewController.swift
//  Translator
//
//  Created by Tianid on 18.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class GroupSelectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let reusableCellId = "CellID"
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
    }
  
    @IBAction func addButtonAction(_ sender: UIButton) {
        createNewGroup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "GroupSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: reusableCellId)
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    
    private func createNewGroup() {
        let alert = UIAlertController(title: nil, message: "Call new group", preferredStyle: .alert)

//        let textField = UITextField()
        alert.addTextField { (textField) in }
       
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert ](_) in
            let textFieldText = alert?.textFields![0].text
            ModelManager.shared.groupsArray.append(textFieldText!)
            let indexPath = IndexPath(item: ModelManager.shared.groupsArray.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
        }))
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    

}

extension GroupSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManager.shared.groupsArray.count ?? 0
//        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId) as! GroupSelectionTableViewCell
        cell.label.text = ModelManager.shared.groupsArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        switch cell?.accessoryType {
        case .checkmark:
            cell?.accessoryType = .none
        case .some(.none):
            cell?.accessoryType = .checkmark
        default:
            break
        }
        
    }
    
    
    
    
    
    
    
    
}
