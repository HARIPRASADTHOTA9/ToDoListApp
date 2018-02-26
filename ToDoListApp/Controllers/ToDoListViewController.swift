//
//  ViewController.swift
//  ToDoListApp
//
//  Created by THOTA HARIPRASAD on 26/02/18.
//  Copyright © 2018 THOTA HARIPRASAD. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        let newItem = Item()
        newItem.title = "find mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "find mike1"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "find mike2"
        itemArray.append(newItem2)

    }
    
    //Mark - Table view data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return itemArray.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Terniry operator:
        // value = condition ? valueiftrue : value if false
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        //cell.accessorytype = item.done ? .checkmark : .none 
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    
    //Mark - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK: add new items
    
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo list item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once user clicks add button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

