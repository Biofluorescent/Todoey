//
//  ViewController.swift
//  Todoey
//
//  Created by Tanner Quesenberry on 12/20/18.
//  Copyright © 2018 Tanner Quesenberry. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Play Smash", "Watch Baking Show", "Take a nap"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
}

