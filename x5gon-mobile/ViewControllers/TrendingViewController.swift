//
//  TrendingViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class TrendingViewController: HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! ContentCell
            cell.set(video: self.contents[indexPath.row - 1])
            return cell
        }
    }
}
