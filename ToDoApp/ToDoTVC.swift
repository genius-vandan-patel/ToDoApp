//
//  ToDoTVC.swift
//  ToDoApp
//
//  Created by Vandan Patel on 12/14/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

class ToDoTVC: UITableViewController, ToDoCellDelegate {

    var toDoItems: [ToDoItem]!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        toDoItems = [ToDoItem]()
        toDoItems = DataManager.loadAll(ToDoItem.self).sorted(by: { (item1, item2) -> Bool in
            item1.createdAt < item2.createdAt
        })
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd(_ sender: UIBarButtonItem) {
        let addAlert = UIAlertController(title: "New ToDo", message: "Enter a title", preferredStyle: .alert)
        addAlert.addTextField { (textField) in
            textField.placeholder = "ToDo Item Title"
        }
        addAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action) in
            guard let title = addAlert.textFields?.first?.text else { return }
            let newToDo = ToDoItem(title: title, completed: false, createdAt: Date(), itemIdentifier: UUID())
            newToDo.saveItem()
            self.toDoItems.append(newToDo)
            let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }))
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addAlert, animated: true, completion: nil)
    }
    
    func didRequestDelete(_ cell: ToDoCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            toDoItems[indexPath.row].deleteItem()
            toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func didRequestComplete(_ cell: ToDoCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            var toDoItem = toDoItems[indexPath.row]
            toDoItem.markAsCompleted()
            cell.toDoLabel.attributedText = strikeThroughText(toDoItem.title)
        }
    }
    
    func strikeThroughText(_ text: String) -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoCell
        cell.delegate = self
        let toDoItem = toDoItems[indexPath.row]
        cell.toDoLabel.text = toDoItem.title
        
        if toDoItem.completed {
            cell.toDoLabel.attributedText = strikeThroughText(toDoItem.title)
        }
        
        return cell
    }
}
