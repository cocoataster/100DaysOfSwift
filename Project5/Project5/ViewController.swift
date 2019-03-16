//
//  ViewController.swift
//  Project5
//
//  Created by Eric Sans Alvarez on 03/03/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

struct ErrorMessage {
    let title: String
    let message: String
}

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Restart button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(startGame))
        
        // Add answer button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let error: ErrorMessage
        
        if isLargeWord(word: lowerAnswer) {
            if isNotInitial(word: lowerAnswer) {
                if isPossible(word: lowerAnswer) {
                    if isOriginal(word: lowerAnswer) {
                        if isReal(word: lowerAnswer) {
                            usedWords.insert(answer, at: 0)
                            
                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                            
                            return
                        } else {
                            error = ErrorMessage(title: "Word not recognized", message: "You can't just make them up")
                        }
                    } else {
                        error = ErrorMessage(title: "Word already used", message: "Be more original")
                    }
                } else {
                    error = ErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title!.lowercased()).")
                }
            } else {
                error = ErrorMessage(title: "That's the initial word!", message: "Choose a different one")
            }
        } else {
            error = ErrorMessage(title: "That's too short", message: "Try with a word with more than 2 letters")
        }
        
        showErrorMessage(error)
    }
    
    func isLargeWord(word: String) -> Bool {
        guard (title?.lowercased()) != nil else { return false }
        
        return word.count > 2 ? true : false
    }
    
    func isNotInitial(word: String) -> Bool {
        guard let tempWord = title?.lowercased() else { return false }
        return tempWord != word ? true : false
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word.capitalized)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMessage(_ error: ErrorMessage) {
        let ac = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}

