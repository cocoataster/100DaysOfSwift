//
//  ViewController.swift
//  Project7
//
//  Created by Eric Sans Alvarez on 17/03/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filterPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Credits", style: .done, target: self, action: #selector(showCredits))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilter))
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "Try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "Date comes from We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Great", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showFilter() {
        let ac = UIAlertController(title: "Search by:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let word = ac?.textFields?.first?.text else { return }
            self?.filterBy(word)
        }
        let cancelAction = UIAlertAction(title: "Remove Filter", style: .destructive) { [weak self] _ in
            guard let petitions = self?.petitions else { return }
            self?.filterPetitions = petitions
            self?.tableView.reloadData()
        }
        ac.addAction(cancelAction)
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func filterBy(_ word: String) {
        // Add to filterPetitions if Petition.title contains word
        filterPetitions = petitions.filter { $0.title.contains(word) }
        tableView.reloadData()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filterPetitions = petitions
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filterPetitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filterPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

