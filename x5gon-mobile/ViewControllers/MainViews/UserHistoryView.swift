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
    //MARK: - Properties
    
    var historyContent = [Content]()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Methods

    func customisation () {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 30, right: 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 80, left: 0, bottom: 30, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = 100
    }
    
    @IBAction func hideHistoryView(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: self.bounds.width, y: 0)
            self.layoutIfNeeded()
        }) { (isSusccessful) in
            self.isHidden = true
            self.transform = .identity
        }
    }
    
    
    
    //MARK:- Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserHistoryViewCell") as! userHistoryViewCell
        let content = historyContent[indexPath.row]
        cell.set(thumbnail: content.thumbnail, title: content.title, channel: content.channel.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: historyContent[indexPath.row])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
}
