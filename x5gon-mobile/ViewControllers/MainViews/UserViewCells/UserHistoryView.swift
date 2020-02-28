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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }
    
}
