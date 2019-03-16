//
//  FlagListTableViewController.swift
//  Challenge1
//
//  Created by Eric Sans Alvarez on 25/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class FlagListTableViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set-up NavigationBar UI
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        print(path)
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items where item.hasSuffix("3x.png") {
            flags.append(item)
        }
        
        flags.shuffle()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return flags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailFlagSegue", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "detailFlagSegue" {
            let flagDetailViewController = segue.destination as! FlagDetailViewController
            flagDetailViewController.flag = flags[(tableView.indexPathForSelectedRow?.row)!]
        }
        
        // Pass the selected object to the new view controller.
        
    }
}
