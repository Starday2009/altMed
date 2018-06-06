//
//  OrdersViewController.swift
//  alt_med
//
//  Created by Oksana Gorbachenko on 3/10/18.
//  Copyright © 2018 Oksana Gorbachenko. All rights reserved.
//
import UIKit
import RealmSwift
import ChameleonFramework
import EventKit

class OrdersTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var searhBar: UISearchBar!
    @IBOutlet  weak var dateTextField: UITextField!
    @IBOutlet var textField: UITextField!
    var ordersItems: Results<Orders>?
    var procedureItems: String = ""
    
    let realm = try! Realm()
    

    var data = ["Маска", "Пилинг", "Массаж лица"]
    var picker = UIPickerView()
    
    
    let dateformatter = DateFormatter()
    
    
    var selectedClient : Clients? {
        didSet{
            loadItems()
        }
    }
    
    var selectedProcedure : Procedures? {
        didSet{
            loadProcedures()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = selectedProcedure?.title as? UIPickerViewDataSource
        
         tableView.rowHeight = 80.0
        
       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        tableView.separatorStyle = .none
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = data[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.short
        dateTextField.text = formatter.string(from: sender.date)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let colourHex = selectedClient?.colour{
            
            title = selectedClient?.name
            guard let colourHex = selectedClient?.colour else {fatalError()}
            updateNavBar(withHexCode: colourHex)
        
            }
         
        }
    
    func updateNavBar (withHexCode colourHexCode: String){
        
    guard let navBar = navigationController?.navigationBar else
    {fatalError("Naigation controller does not exist.")}
        
        guard let navBarColour = UIColor(hexString: colourHexCode) else {fatalError()}
        //            For white naw bar background
        //        let navBarColour = FlatWhite()
        
        navBar.barTintColor = navBarColour
        
        navBar.tintColor = ContrastColorOf(backgroundColor: navBarColour, returnFlat: true)
        
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor :
            ContrastColorOf(backgroundColor: navBarColour, returnFlat: true)]
        searhBar.barTintColor = navBarColour
    
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
       updateNavBar(withHexCode: "1D9BF6")
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath)
        
        if let item = ordersItems?[indexPath.row] {
            
            dateformatter.dateStyle = DateFormatter.Style.short
            dateformatter.timeStyle = DateFormatter.Style.short
            
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = dateformatter.string(for: item.visitTime)
            
            
            if let colour = UIColor(hexString: selectedClient!.colour).darken(byPercentage:CGFloat(indexPath.row) /
                CGFloat(ordersItems!.count)){
                
                cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(backgroundColor: colour, returnFlat: true)
                cell.detailTextLabel?.textColor = ContrastColorOf(backgroundColor: colour, returnFlat: true)
            }
            //Ternary operator ==>
           //value = condition? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = ordersItems?[indexPath.row] {
            do {
                
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Delete by swipe
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if let item = ordersItems?[indexPath.row] {
        do {
            
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Error delete order , \(error)")
        }
    }
    
    tableView.reloadData()
    

    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: Any) {
//        var textField = UITextField()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.addTarget(self, action: #selector(OrdersTableViewController.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
//        var 
        
        let alert = UIAlertController(title: "Запись клиента", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
       
            //what will happen once the user clicks the Add Item button on our UIAlert
            if let currentClient = self.selectedClient {
                do {
                    try self.realm.write {
                        let newItem = Orders()
                        newItem.title = self.textField.text!
                        newItem.dateCreated = Date()
                        newItem.visitTime = datePicker.date
                        currentClient.orders.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.addEventToCalendar(title: "Запись клиента " + (self.selectedClient?.name)!, description: self.textField.text!, startDate: datePicker.date , endDate: datePicker.date.addingTimeInterval(90.0 * 60.0) as Date)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Название процедуры"
            var data = self.selectedProcedure?.title
            self.textField = alertTextField
            self.textField.inputView = self.picker
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Дата проведения"
            self.dateTextField = alertTextField
            self.dateTextField.inputView = datePicker
            }

        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertActionStyle.cancel, handler: {
            (alertAction: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK - Model Manupulation Methods
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
    func loadItems() {
        
        ordersItems = selectedClient?.orders.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
    func loadProcedures() {
        
        procedureItems = (selectedProcedure?.title)!
        
        tableView.reloadData()
        
    }
    
    
    
}

//MARK: - Search bar methods
extension OrdersTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        ordersItems = ordersItems?.filter("title CONTAINS[cd] %@", searchBar.text!)
//            .sorted(byKeyPath: "dateCreated", ascending: true)

        tableView.reloadData()

    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {

            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}


