//
//  CategoryTableViewController.swift
//  ToDoListApp
//
//  Created by THOTA HARIPRASAD on 27/02/18.
//  Copyright © 2018 THOTA HARIPRASAD. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - TABLEVIEW DATASOURCE METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryList", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    //MARK: - DATA MANIPULATION METHODS
    
    func loadCategories(request : NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        }catch {
            print("error reuest in context is, \(error)")
        }
        tableView.reloadData()
    }

    
    func saveCategories() {
        
        do{
            try context.save()
        }catch {
           print("error in saving is \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    
    //MARK: - ADD NEW CATEGORIES

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var userEnteredText = UITextField()
        
        let alert = UIAlertController.init(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            userEnteredText = textField
            textField.placeholder = "ENTER NEW CATEGORY"
        }
        
        let action = UIAlertAction.init(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = userEnteredText.text!
            self.categoryArray.append(newCategory)
            self.saveCategories()
        }

        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TABLEVIEW DELEGATE METHODS
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "gotoItem", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{

            destinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
        
    }
}









