//
//  ViewController.swift
//  CustomTableView
//
//  Created by RMP on 11/06/1448 AH.
//

import UIKit

class ContactViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyTextLabel: UILabel!
    
    var contacts: [Contact] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        delegates()
        
        // at first time
        if contacts.isEmpty {
            tableView.isHidden = true
            emptyTextLabel.isHidden = false
            emptyTextLabel.font = .boldSystemFont(ofSize: 14)
            emptyTextLabel.text = "Empty Contact Press + to Add"
        } else {
            
            tableView.isHidden = false
            emptyTextLabel.isHidden = true
            
        }
    }
    
    
    func delegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addContactViewController = segue.destination as? AddContactViewController else { return }
        addContactViewController.delegate = self
        
    }
  
}


extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //cell.textLabel?.text = "\(contacts[indexPath.row].name) \(contacts[indexPath.row].phoneNumber)"
        
        cell.textLabel?.text = contacts[indexPath.row].name
        
        
        return cell
        
    }
    
    
    
    // MARK: METHOD 1 TO CHANGE SWIPE DELETE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    /*func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create the custom delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Wipe") { (action, view, completionHandler) in
            
            // 1. Remove the item from your data array
            self.contacts.remove(at: indexPath.row)
            
            // 2. Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // 3. Call completion handler to dismiss the swipe view
            completionHandler(true)
        }
        
        // Optional: Customize the action background color
        deleteAction.backgroundColor = .systemRed
        
        // Optional: Add an image icon instead of or alongside text
        // deleteAction.image = UIImage(systemName: "trash")
        
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }*/
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction( style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self else {
                completion(false)
                return
            }
            
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "square.and.arrow.up")
        deleteAction.backgroundColor = .black
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    
    
    // MARK: METHOD 2 TO CHANGE SWIPE DELETE
    /*func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Wipe"
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }

        contacts.remove(at: indexPath.row) // Update your data source
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }*/
    
    
}


extension ContactViewController: SendDataBackwardProtocol {
    
    func sendData(_ name: String, _ phoneNumber: String) {
        
        let contect = Contact(name: name, phoneNumber: phoneNumber)
        contacts.append(contect)
        tableView.reloadData()
        
        // after add the first element
        if contacts.isEmpty {
            tableView.isHidden = true
            emptyTextLabel.isHidden = false
            emptyTextLabel.font = .boldSystemFont(ofSize: 14)
            emptyTextLabel.text = "Empty Contact Press + to Add"
        } else {
            
            tableView.isHidden = false
            emptyTextLabel.isHidden = true
            
        }
    }
}
