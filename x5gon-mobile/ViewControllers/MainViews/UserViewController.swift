//
//  UserViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var historyView: UserHistoryView!
    let menuTitles = ["History", "My Videos", "Notifications", "Watch Later"]
    let defaultItems = 5
    var user = User.init(name: "Loading", profilePic: UIImage(), backgroundImage: UIImage(), playlists: [Playlist]())
    var lastContentOffset: CGFloat = 0.0
    
    //MARK: Methods

    func customisation() {
        self.view.addSubview(historyView)
        self.historyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: self.view, attribute: .top, relatedBy: .equal, toItem: self.historyView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.view, attribute: .left, relatedBy: .equal, toItem: self.historyView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.view, attribute: .right, relatedBy: .equal, toItem: self.historyView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: self.historyView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        self.historyView.isHidden = true
        self.historyView.historyContent = user.historyContent
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! UserHeaderCell
            cell.name.text = self.user.name
            cell.profilePic.image = self.user.profilePic
            cell.backgroundImage.image = self.user.backgroundImage
            return cell
        case 1...4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath) as! UserMenuCell
            cell.menuTitles.text = self.menuTitles[indexPath.row - 1]
            cell.menuIcon.image = UIImage.init(named: self.menuTitles[indexPath.row - 1])
           return cell
        case 5...(self.defaultItems + self.user.playlists.count):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Playlists", for: indexPath) as! UserPlaylistCell
            cell.pic.image = self.user.playlists[indexPath.row - 5].pic
            cell.title.text = self.user.playlists[indexPath.row - 5].title
            cell.numberOfVideos.text = "\(self.user.playlists[indexPath.row - 5].numberOfVideos) videos"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath) as! UserMenuCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func setUser (user: User) {
        self.user = user
    }
    
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customisation()
    }
}




