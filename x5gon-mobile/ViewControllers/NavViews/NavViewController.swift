//
//  NavViewController.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

import UIKit

/// This is a controller used to control the initial view
class NavViewController: UINavigationController, PlayerViewControllerDelegate, SettingsViewControllerDelegate {
    // MARK: - Properties

    /// Player View is displayed when a `content` is tapped
    @IBOutlet var playerView: PlayerView!
    /// Search View will show up if you press the search button
    @IBOutlet var searchView: SearchView!
    /// Setting View will show up if you press the setting button
    @IBOutlet var settingsView: SettingsView!
    /// Login View will show up if you press the login button
    @IBOutlet var loginView: LoginView!

    /// The title of the page
    let titleLabel = UILabel()
    /// Page names
    let names = ["Home", "Featured", "Search Results", "User"]
    /// The origin point of  playerview
    let hiddenOrigin: CGPoint = {
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let x = -UIScreen.main.bounds.width
        let coordinate = CGPoint(x: x, y: y)
        return coordinate
    }()

    /// The origin point of playerview after the minimized prossses is operated
    let minimizedOrigin: CGPoint = {
        let x = UIScreen.main.bounds.width / 2 - 10
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let coordinate = CGPoint(x: x, y: y)
        return coordinate
    }()

    /// The origin point when full screen mode
    let fullScreenOrigin = CGPoint(x: 0, y: 0)

    // MARK: - Methods

    /**
     ### Customise View ###
     - Setup NavigationBarButtons
     - Setup TitleLable
     - Setup Login View
     - Setup Search View
     - Setup Setting View
     - Setup Notification Centre
     */
    func customisation() {
        MainController.navViewController = self

        // NavigationBar buttons

        // Settings Button
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "navSettings"), for: .normal)
        settingsButton.tintColor = UIColor.white
        settingsButton.addTarget(self, action: #selector(showSettings), for: UIControl.Event.touchUpInside)
        navigationBar.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: navigationBar, attribute: .height, relatedBy: .equal, toItem: settingsButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: settingsButton, attribute: .width, relatedBy: .equal, toItem: settingsButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: navigationBar, attribute: .centerY, relatedBy: .equal, toItem: settingsButton, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: navigationBar, attribute: .right, relatedBy: .equal, toItem: settingsButton, attribute: .right, multiplier: 1.0, constant: 10).isActive = true

        // SearchButton
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(named: "navSearch"), for: .normal)
        searchButton.tintColor = UIColor.white
        searchButton.addTarget(self, action: #selector(showSearch), for: UIControl.Event.touchUpInside)
        navigationBar.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: navigationBar, attribute: .height, relatedBy: .equal, toItem: searchButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: searchButton, attribute: .width, relatedBy: .equal, toItem: searchButton, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: navigationBar, attribute: .centerY, relatedBy: .equal, toItem: searchButton, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: searchButton, attribute: .right, relatedBy: .equal, toItem: settingsButton, attribute: .left, multiplier: 1.0, constant: -10).isActive = true

        // TitleLabel setup
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textColor = UIColor.white
        titleLabel.text = names[0]
        navigationBar.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: navigationBar, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: navigationBar, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: navigationBar, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1.0, constant: -15).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        // NavigationBar color and shadow
        navigationBar.barTintColor = Environment.X5Color
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationItem.hidesBackButton = true
        guard let v = view else { return }

        // SearchView setup
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: searchView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: searchView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: searchView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: searchView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        searchView.isHidden = true

        // SettingsView setup
        view.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: settingsView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: settingsView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: settingsView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: settingsView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        settingsView.isHidden = true
        settingsView.delegate = self

        // LoginView setup
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: loginView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: loginView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: loginView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: loginView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        loginView.isHidden = true

        // PlayerView setup
        view.addSubview(playerView)
        playerView.frame = CGRect(origin: hiddenOrigin, size: UIScreen.main.bounds.size)
        playerView.delegate = self

        // NotificaionCenter Setup
        NotificationCenter.default.addObserver(self, selector: #selector(changeTitle(notification:)), name: Notification.Name(rawValue: "scrollMenu"), object: nil)
    }

    /// Show Search View
    @objc func showSearch() {
        searchView.alpha = 0
        searchView.isHidden = false
        view.bringSubviewToFront(searchView)
        UIView.animate(withDuration: 0.2, animations: {
            self.searchView.alpha = 1
        }) { _ in
            self.searchView.inputField.becomeFirstResponder()
        }
    }

    /// Show Setting view
    @objc func showSettings() {
        settingsView.isHidden = false
        settingsView.tableViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.settingsView.backgroundView.alpha = 0.5
            self.settingsView.layoutIfNeeded()
        }
    }

    /// Show login view
    func showLogin() {
        loginView.isHidden = false
        loginView.viewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.loginView.backgroundView.alpha = 0.5
            self.loginView.layoutIfNeeded()
        }
    }

    /// Change th title
    @objc func changeTitle(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: CGFloat]
            titleLabel.text = names[Int(round(userInfo["length"]!))]
        }
    }

    /**
     Animate to the state of the viewController

     ### Usage Example: ###
     ````
     let content = NaviViewController.animatePlayView(.hidden)

     ````
     - Parameter toState: `fullScreen`, `minimized`, `hidden`
     */
    func animatePlayView(toState: stateOfViewController) {
        switch toState {
        case .fullScreen:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [.beginFromCurrentState], animations: {
                self.playerView.frame.origin = self.fullScreenOrigin
            })
            MainController.setHideTopBar(hide: true)
        case .minimized:
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.frame.origin = self.minimizedOrigin
            })
            MainController.setHideTopBar(hide: false)
        case .hidden:
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.frame.origin = self.hiddenOrigin
            })
            MainController.setHideTopBar(hide: false)
        }
    }

    /// Detect the swipe position
    func positionDuringSwipe(scaleFactor: CGFloat) -> CGPoint {
        let width = UIScreen.main.bounds.width * 0.5 * scaleFactor
        let height = width * 9 / 16
        let x = (UIScreen.main.bounds.width - 10) * scaleFactor - width
        let y = (UIScreen.main.bounds.height - 10) * scaleFactor - height
        let coordinate = CGPoint(x: x, y: y)
        return coordinate
    }

    /// Set prefer status bar Hidden
    func setPreferStatusBarHidden(_ preferHidden: Bool) {
        isHidden = preferHidden
    }

    /// True if the `Content`  is hidden
    var isHidden = true {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    // MARK: Delegate

    /// Animate `palyView` to minimise
    func didMinimize() {
        animatePlayView(toState: .minimized)
    }

    /// Animate to fullScreen display the playview
    func didmaximize() {
        animatePlayView(toState: .fullScreen)
    }

    /// Detech if the user end swipe
    func didEndedSwipe(toState: stateOfViewController) {
        animatePlayView(toState: toState)
    }

    /// Swipe to the state of view Controller
    func swipeToMinimize(translation: CGFloat, toState: stateOfViewController) {
        switch toState {
        case .fullScreen:
            playerView.frame.origin = positionDuringSwipe(scaleFactor: translation)
        case .hidden:
            playerView.frame.origin.x = UIScreen.main.bounds.width / 2 - abs(translation) - 10
        case .minimized:
            playerView.frame.origin = positionDuringSwipe(scaleFactor: translation)
        }
    }

    /// Return the value of `isHidden`
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }

    // MARK: - ViewController lifecycle

    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()
    }

    /// Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    /**
     Notifies the view controller that its view was added to a view hierarchy.
     */
    override func viewDidAppear(_: Bool) {
        super.viewWillAppear(true)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }.first
        if let window = keyWindow {
            window.addSubview(playerView)
        }
    }
}
