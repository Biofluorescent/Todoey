//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Tanner Quesenberry on 12/26/18.
//  Copyright © 2018 Tanner Quesenberry. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    //DDatabase
    let realm = try! Realm()
    
    // Auto updating realm container of Category Class
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }


    //MARK: - Tableview Datasource Methods
    
    // How many rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    // Each row displays
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get swipeable cell from superclass
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        //Set text of cell for that category
        if let category = categoryArray?[indexPath.row]{
            cell.textLabel?.text = category.name
            
            //Set cell/text color for category
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(){
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        //Delete category at swiped indexpath.row
        if let toDelete = self.categoryArray?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(toDelete)
                }
            } catch{
                print("Error deleting category, \(error)")
            }
        }
        
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // Move text between closures
        var textField = UITextField()
        
        // Create alert
        let alert = UIAlertController(title: "Add A New Category", message: "", preferredStyle: .alert)
        
        // Create alert action
        let action = UIAlertAction(title: "Add Category", style: .default)
        { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            
            self.save(category: newCategory)
        }
        
        // Textfield for user to enter data
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter New Category"
            textField = alertTextField
        }
        
        // Add button action to alert. Show alert
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
    }
    
    
    
}


