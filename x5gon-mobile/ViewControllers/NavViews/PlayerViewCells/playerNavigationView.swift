//
//  playerNavigationView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 23/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class playerNavigationView: UIView, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    @IBOutlet weak var backgroundView: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var wiki: Wiki?
    var tableViewContent = [String]()
    
    //MARK: - Methods
    func customisation () {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.backgroundView.alpha = 0
        self.layoutIfNeeded()
    }
    
    @IBAction func hideNavigationView(_ sender: Any) {
        UIView.animate(withDuration: 0.6, animations: {
            self.tableView.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
            self.backgroundView.alpha = 0
            self.layoutIfNeeded()
        }) { (isSuccessful) in
            self.isHidden = true
            self.tableView.transform = .identity
        }
    }
    
    func setWiki (wiki: Wiki) {
        self.wiki = wiki
        self.tableViewContent.removeAll()
        var chunkNum = 1
        for chunk in self.wiki!.chunks {
            var entityNum = 1
            for entity in chunk.entities {
                tableViewContent.append("\(chunkNum).\(entityNum) \(entity.title)")
                entityNum += 1
            }
            chunkNum += 1
        }
    }
    
    //MARK: - Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (wiki == nil) {
            return UITableViewCell.init()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNavigationCell")!
        cell.textLabel?.text = tableViewContent[indexPath.row]
        return cell
    }
    
    //MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customisation()
    }
    
}
