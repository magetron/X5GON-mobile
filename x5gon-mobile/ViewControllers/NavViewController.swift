//
//  NavViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController, PlayerViewControllerDelegate  {

    //MARK: Properties
    @IBOutlet var playerView: PlayerView!
    @IBOutlet var searchView: SearchView!
    @IBOutlet var settingsView: SettingsView!
    let titleLabel = UILabel()
    let names = ["Home", "Trending", "Subscriptions", "Account"]
    let hiddenOrigin: CGPoint = {
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let x = -UIScreen.main.bounds.width
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let minimizedOrigin: CGPoint = {
        let x = UIScreen.main.bounds.width/2 - 10
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }()
    let fullScreenOrigin = CGPoint.init(x: 0, y: 0)

    //Methods
    func customization() {
        //NavigationBar buttons
        //Settings Button
        let settingsButton = UIButton.init(type: .system)
        settingsButton.setImage(UIImage.init(named: "navSettings"), for: .normal)
        settingsButton.tintColor = UIColor.white;
        settingsButton.addTarget(self, action: #selector(self.showSettings), for: UIControl.Event.touchUpInside)
        self.navigationBar.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        let _ = NSLayoutConstraint.init(item: self.navigationBar, attribute: .height, relatedBy: .equal, toItem: settingsButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: settingsButton, attribute: .width, relatedBy: .equal, toItem: settingsButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: self.navigationBar, attribute: .centerY, relatedBy: .equal, toItem: settingsButton, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: self.navigationBar, attribute: .right, relatedBy: .equal, toItem: settingsButton, attribute: .right, multiplier: 1.0, constant: 10).isActive = true
        //SearchButton
        let searchButton = UIButton.init(type: .system)
        searchButton.setImage(UIImage.init(named: "navSearch"), for: .normal)
        searchButton.tintColor = UIColor.white;
        searchButton.addTarget(self, action: #selector(self.showSearch), for: UIControl.Event.touchUpInside)
        self.navigationBar.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        let _ = NSLayoutConstraint.init(item: self.navigationBar, attribute: .height, relatedBy: .equal, toItem: searchButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: searchButton, attribute: .width, relatedBy: .equal, toItem: searchButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: self.navigationBar, attribute: .centerY, relatedBy: .equal, toItem: searchButton, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: searchButton, attribute: .right, relatedBy: .equal, toItem: settingsButton, attribute: .left, multiplier: 1.0, constant: -10).isActive = true
        //TitleLabel setup
        self.titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.titleLabel.textColor =  UIColor.white
        self.titleLabel.text = self.names[0]
        self.navigationBar.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let _ = NSLayoutConstraint.init(item: self.navigationBar, attribute: .centerY, relatedBy: .equal, toItem: self.titleLabel, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: self.navigationBar, attribute: .height, relatedBy: .equal, toItem: self.titleLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: self.navigationBar, attribute: .left, relatedBy: .equal, toItem: self.titleLabel, attribute: .left, multiplier: 1.0, constant: -10).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //NavigationBar color and shadow
        self.navigationBar.barTintColor = Environment.X5Color
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        //SearchView setup
        self.view.addSubview(self.searchView)
        self.searchView.translatesAutoresizingMaskIntoConstraints = false
        guard let v = self.view else { return }
        let _ = NSLayoutConstraint.init(item: v, attribute: .top, relatedBy: .equal, toItem: self.searchView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .left, relatedBy: .equal, toItem: self.searchView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .right, relatedBy: .equal, toItem: self.searchView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .bottom, relatedBy: .equal, toItem: self.searchView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        self.searchView.isHidden = true
        //SettingsView setup
        self.view.addSubview(self.settingsView)
        self.settingsView.translatesAutoresizingMaskIntoConstraints = false
        let _ = NSLayoutConstraint.init(item: v, attribute: .top, relatedBy: .equal, toItem: self.settingsView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .left, relatedBy: .equal, toItem: self.settingsView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .right, relatedBy: .equal, toItem: self.settingsView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        let _ = NSLayoutConstraint.init(item: v, attribute: .bottom, relatedBy: .equal, toItem: self.settingsView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        self.settingsView.isHidden = true
        //PLayerView setup
        self.playerView.frame = CGRect.init(origin: self.hiddenOrigin, size: UIScreen.main.bounds.size)
        self.playerView.delegate = self
        //NotificaionCenter Setup
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTitle(notification:)), name: Notification.Name.init(rawValue: "scrollMenu"), object: nil)
    }
    
    @objc func showSearch()  {
        self.searchView.alpha = 0
        self.searchView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.searchView.alpha = 1
        }) { _ in
            self.searchView.inputField.becomeFirstResponder()
        }
    }
    
    @objc func showSettings() {
        self.settingsView.isHidden = false
        self.settingsView.tableViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) { 
            self.settingsView.backgroundView.alpha = 0.5
            self.settingsView.layoutIfNeeded()
        }
    }
    
    @objc func changeTitle(notification: Notification)  {
        if let info = notification.userInfo {
            let userInfo = info as! [String: CGFloat]
            self.titleLabel.text = self.names[Int(round(userInfo["length"]!))]
        }
    }
    
    func animatePlayView(toState: stateOfViewController) {
        switch toState {
        case .fullScreen:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [.beginFromCurrentState], animations: {
                self.playerView.frame.origin = self.fullScreenOrigin
            })
            setHide(hide: true)
        case .minimized:
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.frame.origin = self.minimizedOrigin
            })
            setHide(hide: false)
        case .hidden:
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.frame.origin = self.hiddenOrigin
            })
            setHide(hide: false)
        }
    }
    
    func setHide(hide: Bool) {
        if (hide) {
            self.navigationBar.barTintColor = UIColor.black
            Environment.mainViewController?.tabBarView.collectionView.isHidden = true
            Environment.mainViewController?.tabBarView.backgroundColor = UIColor.black
        } else {
            self.navigationBar.barTintColor = Environment.X5Color
            Environment.mainViewController?.tabBarView.collectionView.isHidden = false
            Environment.mainViewController?.tabBarView.backgroundColor = Environment.X5Color
        }
    }
    
    func positionDuringSwipe(scaleFactor: CGFloat) -> CGPoint {
        let width = UIScreen.main.bounds.width * 0.5 * scaleFactor
        let height = width * 9 / 16
        let x = (UIScreen.main.bounds.width - 10) * scaleFactor - width
        let y = (UIScreen.main.bounds.height - 10) * scaleFactor - height
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }
    
    //MARK: Delegate methods
    func didMinimize() {
        self.animatePlayView(toState: .minimized)
    }
    
    func didmaximize(){
        self.animatePlayView(toState: .fullScreen)
    }
    
    func didEndedSwipe(toState: stateOfViewController){
        self.animatePlayView(toState: toState)
    }
    
    func swipeToMinimize(translation: CGFloat, toState: stateOfViewController){
        switch toState {
        case .fullScreen:
            self.playerView.frame.origin = self.positionDuringSwipe(scaleFactor: translation)
        case .hidden:
            self.playerView.frame.origin.x = UIScreen.main.bounds.width/2 - abs(translation) - 10
        case .minimized:
            self.playerView.frame.origin = self.positionDuringSwipe(scaleFactor: translation)
        }
    }
    
    func setPreferStatusBarHidden(_ preferHidden: Bool) {
        self.isHidden = preferHidden
    }
    
    var isHidden = true {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
    
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        if let window = keyWindow {
            window.addSubview(self.playerView)
        }
    }
}
