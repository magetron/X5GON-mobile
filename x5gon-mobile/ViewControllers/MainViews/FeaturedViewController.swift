//
//  TrendingViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var contents = [Content]()
    var lastContentOffset: CGFloat = 0.0
    
    //MARK: Methods
    func customisation() {
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        refresher(updateContent: {() -> Void in self.contents = MainController.fetchDefaultContents()}, viewReload: {() -> Void in self.tableView.reloadData()})
    }
    
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell") as! ContentCell
            cell.set(video: self.contents[indexPath.row - 1])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: contents[indexPath.row])
    }
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customisation()
    }
}

