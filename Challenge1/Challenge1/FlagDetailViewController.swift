//
//  ViewController.swift
//  Challenge1
//
//  Created by Eric Sans Alvarez on 25/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class FlagDetailViewController: UIViewController {
    
    @IBOutlet weak var flagImageView: UIImageView!
    var flag: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
        
        if let detailFlag = flag {
            flagImageView.image = UIImage(named: detailFlag)
        }
    }
    
    @objc func shareFlag() {
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        let shareViewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        
        // iPad
        shareViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(shareViewController, animated: true)
    }

}

