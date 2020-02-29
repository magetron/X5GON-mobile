//
//  UserHistoryTableView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 28/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import Foundation
import UIKit

class UserHistoryView : UIView, UITableViewDelegate, UITableViewDataSource {
    
    var historyContent = [Content]()
    @IBOutlet weak var tableView: UITableView!

    func customisation () {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserHistoryViewCell") as! userHistoryViewCell
        let content = historyContent[indexPath.row]
        cell.set(thumbnail: content.thumbnail, title: content.title, channel: content.channel.name)
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
}
