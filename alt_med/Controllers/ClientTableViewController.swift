//
//  ClientTableViewController.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 3/6/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class ClientTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var clients : Results<Clients>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.leftItemsSupplementBackButton = false
        loadClients()
        tableView.rowHeight = 80.0
        
         tableView.separatorStyle = .none
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientsCell", for: indexPath)
        
        cell.textLabel?.text = clients?[indexPath.row].name ?? "No clients added yet"
        
        cell.backgroundColor = UIColor(hexString: clients?[indexPath.row].colour ?? "1D9BF6")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToOrders", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! OrdersTableViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedClient = clients?[indexPath.row]
        }
    }

    
    
    func save(client: Clients) {
        do {
            try realm.write {
                realm.add(client)
            }
        } catch {
            print("Error saving client \(error)")
        }
        
        tableView.reloadData()
        
    }
    
        func loadClients(){
            
        clients = realm.objects(Clients.self)
            
        tableView.reloadData()
            
        }
 
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()
        
        let alert = UIAlertController(title: "Добавление клиента", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            let newClient = Clients()
            newClient.name = textField.text!
            newClient.colour = UIColor.randomFlat().hexValue()
            
            self.save(client: newClient)
            
        }
        
        alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.cancel, handler: {
            (alertAction: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Введите имя"
        }
        
        present(alert, animated: true, completion: nil)
        
       tableView.reloadData()
    }
    
    
    //Delete by swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let item = clients?[indexPath.row] {
            do {
                
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error delete client, \(error)")
            }
        }
        
        tableView.reloadData()
        
        
    }
    //Edit by swipe
    override func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Edit")
            self.performSegue(withIdentifier: "goToEditClient", sender: self)
            success(true)
        })
        editAction.backgroundColor = .gray
        
        
        return UISwipeActionsConfiguration(actions:[editAction])
    }

    
}
