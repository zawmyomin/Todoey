//
//  ViewController.swift
//  Todoey
//
//  Created by Zaw Myo Min on 3/15/18.
//  Copyright © 2018 zawmyomin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var  itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems()
        
//        let newItem = Item()
//        newItem.title = "Kaung Kaung"
//        newItem.done = true
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Kyaw Kyaw"
//        itemArray.append(newItem2)
//
//
//        let newItem3 = Item()
//        newItem3.title = "Kyaw Kyaw"
//        itemArray.append(newItem3)
//
//        let newItem4 = Item()
//        newItem4.title = "Kyaw Kyaw"
//        itemArray.append(newItem4)
        
      

    }
    
    @IBAction func addBtn(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user click  the add item button on our Alert
            print("Success")
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveItems()
            
            let encoder = PropertyListEncoder()
            
            do {
            let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            }catch {
                print("Error enconding item array, \(error)")
            }
//            self.defaults.set(self.itemArray, forKey: "TodolsitArray")
            
            self.tableView.reloadData()
        
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            print(alertTextField.text)
            textField = alertTextField
            print("NOW")
        }
     
         alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
        let item = itemArray[indexPath.row]
         cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //Value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if  itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
//
        saveItems()
        
        if tableView.cellForRow(at: indexPath)?.accessoryType  == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch {
            print("Error encoding item array, \(error)")
        }
        
        
    }
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print("Error decoding item array, \(error)")
            }
        }
    }

}

