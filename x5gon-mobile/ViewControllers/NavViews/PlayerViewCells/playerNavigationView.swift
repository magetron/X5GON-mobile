//
//  playerNavigationView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 23/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class playerNavigationView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backgroundView: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var wiki: Wiki?
    
    func customisation () {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.backgroundView.alpha = 0
        self.layoutIfNeeded()
    }
    
    @IBAction func hideNavigationView(_ sender: Any) {
        self.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (wiki == nil) {
            return 0
        }
        var count = 0
        for chunk in wiki!.chunks {
            count += chunk.entities.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (wiki == nil) {
            return UITableViewCell.init()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNavigationCell", for: indexPath)
        let prefixString = "\(indexPath.row / wiki!.chunks.count).\(indexPath.row % wiki!.chunks.count)"
        let contentString = wiki!.chunks[indexPath.row / wiki!.chunks.count].entities[indexPath.row % wiki!.chunks.count].title
        cell.textLabel?.text = prefixString + contentString
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customisation()
    }
    
}
