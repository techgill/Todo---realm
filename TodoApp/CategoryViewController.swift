//
//  CategoryViewController.swift
//  TodoApp
//
//  Created by Gill Hardeep on 08/04/20.
//  Copyright © 2020 Gill Hardeep. All rights reserved.
//


import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    var categoryArray: Results<CategoryClass>?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
    }
    
    //MARK: - data populate tableview methon
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "nothing added yet"
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var text = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            let newCategory = CategoryClass()
            newCategory.name = text.text!
            
            self.save(category: newCategory)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (action) in
            print(action)
        }
        
        alert.addTextField { (alertTextField) in
            text = alertTextField
            text.placeholder = "add new category"
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    func updateModel(at indexPath: IndexPath) {
        if let categories = self.categoryArray?[indexPath.row]{
            do{
                try self.realm.write{
                    self.realm.delete(categories)
                }
            }catch{
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    func save(category: CategoryClass){
        do{
            try self.realm.write{
                self.realm.add(category)
            }
        }catch{
            print(error)
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        categoryArray = realm.objects(CategoryClass.self)
        tableView.reloadData()
    }
    
}

