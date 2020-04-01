//
//  playerNavigationView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 23/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class playerNavigationView: UIView, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Properties

    @IBOutlet var backgroundView: UIButton!
    @IBOutlet var tableView: UITableView!
    var wiki: Wiki?
    var tableViewContent = [String]()

    // MARK: - Methods

    func customisation() {
        tableView.delegate = self
        tableView.dataSource = self
        backgroundView.alpha = 0
        layoutIfNeeded()
    }

    @IBAction func hideNavigationView(_: Any) {
        UIView.animate(withDuration: 0.6, animations: {
            self.tableView.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
            self.backgroundView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
            self.tableView.transform = .identity
        }
    }

    func setWiki(wiki: Wiki) {
        self.wiki = wiki
        tableViewContent.removeAll()
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

    // MARK: - Delegates

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return tableViewContent.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if wiki == nil {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerNavigationCell")!
        cell.textLabel?.text = tableViewContent[indexPath.row]
        return cell
    }

    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
}
