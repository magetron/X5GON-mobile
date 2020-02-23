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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customisation()
    }
    
}
