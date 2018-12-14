//
//  CatogoryViewController.swift
//  Todoit002
//
//  Created by chen wei hang on 2018/12/13.
//  Copyright © 2018 U coffee 001. All rights reserved.
//

import UIKit
import CoreData


class CatogoryViewController: UITableViewController {
    
    var catoArray = [Catogory]()
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCatogories()

    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatogoryCell", for: indexPath)
        
        
        cell.textLabel?.text = catoArray[indexPath.row].name
        
        
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListviewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCatogory = catoArray[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCatogories() {
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCatogories(){
        let request : NSFetchRequest<Catogory> = Catogory.fetchRequest()
        do{
            catoArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
         tableView.reloadData()
    }
    @IBAction func newButtonpressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Catogory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add ", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            
            let newCatogory = Catogory(context: self.context)
            newCatogory.name = textField.text!
            self.catoArray.append(newCatogory)
            self.saveCatogories()
    }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new catogory"
        }
        
        present(alert, animated: true, completion: nil)
        
}

    //MARK: - Add New Catogories
    

        

    
    
    
        
        
        
        
    
    
    
}
