//
//  ViewController.swift
//  Todoey
//
//  Created by Tanner Quesenberry on 12/20/18.
//  Copyright © 2018 Tanner Quesenberry. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Play Smash", "Watch Baking Show", "Take a nap"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
                itemArray = items
        }
        
    }

    //MARK - Tableview Datasource Methods
    
    //What cells should display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell linked to identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // Set cell text of itemArray based off current index
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //How many rows to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //MARK - TableViewDelegate Methods
    
    // When clicking on TableView Cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Flash gray animation
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        
        // Display or dismiss checkmark
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        }else{
            cell?.accessoryType = .checkmark
        }
        
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //Move text between closures
        var textField = UITextField()
        
        //Create alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //Create alert action
        let action =  UIAlertAction(title: "Add Item", style: .default)
        { (action) in
            // what happens when user clicks the Add item on UIalert
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        // Textfield created for user to enter data, preset.
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter New Item"
            textField = alertTextField
        }
        
        // Add button action to alert. Show alert to user.
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

