//
//  ProcedureTableViewController.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 5/10/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
import EventKit

class ProcedureTableViewController: UITableViewController {

    let realm = try! Realm()
    var procedures : Results<Procedures>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        tableView.rowHeight = 80.0
        
        tableView.separatorStyle = .none
        
    }
    
    var selectedProcedure : Procedures? {
        didSet{
            loadItems()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return procedures?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proceduresCell", for: indexPath)
        
        cell.textLabel?.text = procedures?[indexPath.row].title ?? "No clients added yet"
        
        cell.backgroundColor = UIColor(hexString: procedures?[indexPath.row].colour ?? "1D9BF6")
        
        return cell
    }
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Добавить новую процедуру", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            let newProcedure = Procedures()
            newProcedure.title = textField.text!
            newProcedure.colour = UIColor.randomFlat().hexValue()
            
            self.save(procedure: newProcedure)
            
        }
        
        alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.cancel, handler: {
            (alertAction: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Название процедуры.."
        }
        
        present(alert, animated: true, completion: nil)
        
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ProcedureTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedProcedure = procedures?[indexPath.row]
        }
    }
    
    func save(procedure: Procedures) {
        do {
            try realm.write {
                realm.add(procedure)
            }
        } catch {
            print("Error saving procedure \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems(){
        
        procedures = realm.objects(Procedures.self)
        
        tableView.reloadData()
        
    }
    
    
    //Delete by swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let item = procedures?[indexPath.row] {
            do {
                
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error delete procedure, \(error)")
            }
        }
        
        tableView.reloadData()
        
        
    }
    

}
