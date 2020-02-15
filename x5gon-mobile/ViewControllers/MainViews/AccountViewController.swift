//
//  AccountViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let menuTitles = ["History", "My Videos", "Notifications", "Watch Later"]
    let defaultItems = 5
    var user = User.init(name: "Loading", profilePic: UIImage(), backgroundImage: UIImage(), playlists: [Playlist]())
    var lastContentOffset: CGFloat = 0.0
    
    //MARK: Methods

    func customization() {
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        self.user = User.generateDefaultUser()
        self.tableView.reloadData()
    }
    
    // MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.defaultItems + self.user.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! AccountHeaderCell
            cell.name.text = self.user.name
            cell.profilePic.image = self.user.profilePic
            cell.backgroundImage.image = self.user.backgroundImage
            return cell
        case 1...4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath) as! AccountMenuCell
            cell.menuTitles.text = self.menuTitles[indexPath.row - 1]
            cell.menuIcon.image = UIImage.init(named: self.menuTitles[indexPath.row - 1])
           return cell
        case 5...(self.defaultItems + self.user.playlists.count):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Playlists", for: indexPath) as! AccountPlaylistCell
            cell.pic.image = self.user.playlists[indexPath.row - 5].pic
            cell.title.text = self.user.playlists[indexPath.row - 5].title
            cell.numberOfVideos.text = "\(self.user.playlists[indexPath.row - 5].numberOfVideos) videos"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath) as! AccountMenuCell
            return cell
        }
    }
    
    func setUser (user: User) {
        self.user = user
    }
    
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
    }
}




