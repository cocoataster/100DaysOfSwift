//
//  ViewController.swift
//  Challenge2
//
//  Created by Eric Sans Alvarez on 08/03/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Properties
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
    }
    
    // MARK: - Set up User Interface
    func loadSubviews() {
        navigationItem.title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptItemAlert))
    }
    
    // MARK: - Prompt Item Alert
    @objc func promptItemAlert() {
        let alertController = UIAlertController(title: "What Do You Need?", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController] (_) in
            guard let newItem = alertController?.textFields?.first?.text else { return }
            self?.addItem(newItem)
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Add Item
    func addItem(_ newItem: String) {
        shoppingList.insert(newItem.capitalized, at: shoppingList.count)
        tableView.insertRows(at: [IndexPath(row: shoppingList.count-1, section: 0)], with: .automatic)
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

}
