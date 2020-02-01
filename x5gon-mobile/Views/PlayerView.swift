//
//  VideoPlayerView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

protocol PlayerViewControllerDelegate {
    func didMinimize()
    func didmaximize()
    func swipeToMinimize(translation: CGFloat, toState: stateOfViewController)
    func didEndedSwipe(toState: stateOfViewController)
    func setPreferStatusBarHidden(_ preferHidden: Bool)
}

import UIKit
import AVFoundation
import AVKit

class PlayerView: UIView, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var player: UIView!
    var content: ContentModel!
    var delegate: PlayerViewControllerDelegate?
    var state = stateOfViewController.hidden
    var direction = Direction.none
    var videoPlayerViewController = AVPlayerViewController()
    
    //MARK: Methods
    func customization() {
        self.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 90
        self.player.layer.anchorPoint.applying(CGAffineTransform.init(translationX: -0.5, y: -0.5))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.player.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.resumePlayView)))
        videoPlayerViewController.view.frame = self.player.frame
        videoPlayerViewController.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPlayerViewController.showsPlaybackControls = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.tapPlayView), name: NSNotification.Name("open"), object: nil)
    }
    
    func animate()  {
        switch self.state {
            case .fullScreen:
                UIView.animate(withDuration: 0.3, animations: {
                    self.tableView.alpha = 1
                    self.player.transform = CGAffineTransform.identity
                    self.delegate?.setPreferStatusBarHidden(true)
                })
            case .minimized:
                UIView.animate(withDuration: 0.3, animations: {
                    self.delegate?.setPreferStatusBarHidden(false)
                    self.tableView.alpha = 0
                    let scale = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
                    let trasform = scale.concatenating(CGAffineTransform.init(translationX: -self.player.bounds.width/4, y: -self.player.bounds.height/4))
                    self.player.transform = trasform
                })
            default: break
        }
    }
    
    func changeValues(scaleFactor: CGFloat) {
        self.tableView.alpha = 1 - scaleFactor
        let scale = CGAffineTransform.init(scaleX: (1 - 0.5 * scaleFactor), y: (1 - 0.5 * scaleFactor))
        let trasform = scale.concatenating(CGAffineTransform.init(translationX: -(self.player.bounds.width / 4 * scaleFactor), y: -(self.player.bounds.height / 4 * scaleFactor)))
        self.player.transform = trasform
    }
    

    @objc func resumePlayView() {
        self.videoPlayerViewController.player?.play()
        self.state = .fullScreen
        self.delegate?.didmaximize()
        self.animate()
    }
    
    @objc func tapPlayView(_ notification: Notification) {
        print("called")
        print(notification.object is VideoModel)
        if let video = notification.object as? VideoModel {
            setVideo(video: video)
        } else if let pdf = notification.object as? PDFModel {
            setPDF(pdf: pdf)
        }
        self.videoPlayerViewController.player?.play()
        self.state = .fullScreen
        self.delegate?.didmaximize()
        self.animate()
    }
    
    @IBAction func minimize(_ sender: UIButton) {
        self.state = .minimized
        self.delegate?.didMinimize()
        self.animate()
    }
    
    @IBAction func minimizeGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            let velocity = sender.velocity(in: nil)
            if abs(velocity.x) < abs(velocity.y) {
                self.direction = .up
            } else {
                self.direction = .left
            }
        }
        var finalState = stateOfViewController.fullScreen
        switch self.state {
        case .fullScreen:
            let factor = (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
            self.changeValues(scaleFactor: factor)
            self.delegate?.swipeToMinimize(translation: factor, toState: .minimized)
            finalState = .minimized
        case .minimized:
            if self.direction == .left {
                finalState = .hidden
                let factor: CGFloat = sender.translation(in: nil).x
                self.delegate?.swipeToMinimize(translation: factor, toState: .hidden)
            } else {
                finalState = .fullScreen
                let factor = 1 - (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
                self.changeValues(scaleFactor: factor)
                self.delegate?.swipeToMinimize(translation: factor, toState: .fullScreen)
            }
        default: break
        }
        if sender.state == .ended {
            self.state = finalState
            self.animate()
            self.delegate?.didEndedSwipe(toState: self.state)
            if self.state == .hidden {
                self.videoPlayerViewController.player?.pause()
            }
        }
    }
    
    //MARK: Delegate & dataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.content?.suggestedContents.count {
            return count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! headerCell
            cell.set(content: self.content, onLikeTapFunc: self.OnLikeTap, onDisLikeTapFunc: self.OnDisLikeTap)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! suggestionContentCell
            cell.set(content: (self.content.suggestedContents[indexPath.row - 1]))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            return
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("open"), object: self.content.suggestedContents[indexPath.row - 1])
        }
    }
    
    //MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customization()
    }
    
    func setVideo(video : VideoModel) {
        self.content = video
        let selfVideo = self.content as! VideoModel
        self.player.subviews.forEach({ $0.removeFromSuperview() })
        self.player.addSubview(videoPlayerViewController.view)
        if self.videoPlayerViewController.player == nil {
            self.videoPlayerViewController.player = AVPlayer()
        }

        if selfVideo.videoLink != nil {
            self.videoPlayerViewController.player?.replaceCurrentItem(with: AVPlayerItem.init(url: selfVideo.videoLink))
        }
        if selfVideo.suggestedContents.count == 0 {
            selfVideo.fetchSuggestedContents(async: true, refresher: self.refresher)
        }
        if self.state != .hidden {
            self.videoPlayerViewController.player?.play()
        }
        self.tableView.reloadData()
    }
    
    func setPDF(pdf : PDFModel) {
        self.content = pdf
    }
    
    func OnLikeTap () {
        self.content.likes += 1
        refresher()
    }
    
    func OnDisLikeTap () {
        self.content.disLikes += 1
        refresher()
    }
    
    func refresher () {
        self.tableView.reloadData()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
