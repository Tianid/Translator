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
    var dataTuple: (english: String, russian: String)?
    private let reusableCellId = "CellID"
    private var selectedGroups = [Int]()
    private var presenter: GroupSelectionPresenterProtocol = GroupSelectionPresenter()

    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        presenter.saveTranslatedTextIntoSelectedGroups(selectedGroups: selectedGroups, context: context!, translation: (english: dataTuple!.english, russian: dataTuple!.russian))
    }
  
    @IBAction func addButtonAction(_ sender: UIButton) {
        createNewGroup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.groupSelectionViewController = self
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

extension GroupSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManager.shared.groupsArray.count
//        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId) as! GroupSelectionTableViewCell
        cell.label.text = ModelManager.shared.groupsArray[indexPath.row].groupName
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        switch cell?.accessoryType {
        case .checkmark:
            selectedGroups.removeAll { (value) -> Bool in
                guard value == indexPath.row else { return false }
                return true
            }
            cell?.accessoryType = .none
        case .some(.none):
            selectedGroups.append(indexPath.row)
            cell?.accessoryType = .checkmark
        default:
            break
        }
        
    }
    
    
    
    
    
    
    
    
}
extension GroupSelectionViewController: GroupSelectionProtocol {
    
}
