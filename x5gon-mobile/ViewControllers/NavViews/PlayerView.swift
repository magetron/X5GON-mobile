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
import PDFKit

class PlayerView: UIView, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, PlayerViewHeaderCellDelegate {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var player: UIView!
    @IBOutlet weak var navigationViewButton: UIButton!
    @IBOutlet weak var navigationView: playerNavigationView!
    
    var content: Content!
    var delegate: PlayerViewControllerDelegate?
    var state = stateOfViewController.hidden
    var direction = Direction.none
    var pdfView = PDFView()
    let videoPlayerViewController = AVPlayerViewController()

    
    //MARK: Methods
    func customisation() {
        self.addSubview(self.navigationView)
        self.navigationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: self.navigationView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .left, relatedBy: .equal, toItem: self.navigationView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .right, relatedBy: .equal, toItem: self.navigationView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.navigationView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        self.navigationView.isHidden = true
        
        self.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 90
        self.player.layer.anchorPoint.applying(CGAffineTransform.init(translationX: -0.5, y: -0.5))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.player.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.resumePlayerView)))
        videoPlayerViewController.view.frame = self.player.frame
        videoPlayerViewController.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPlayerViewController.showsPlaybackControls = true
        pdfView.frame = self.player.frame
        pdfView.displayMode = PDFDisplayMode.singlePage
        NotificationCenter.default.addObserver(self, selector: #selector(self.newPlayerView), name: NSNotification.Name("open"), object: nil)
    }
    
    @IBAction func showNavigation(_ sender: Any) {
        self.navigationView.isHidden = false
        self.navigationView.tableView.center.x += self.navigationView.bounds.width;
        UIView.animate(withDuration: 0.6) {
            self.navigationView.backgroundView.alpha = 0.5
            self.navigationView.tableView.center.x -= self.navigationView.bounds.width
        }
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
    

    @objc func resumePlayerView() {
        self.videoPlayerViewController.player?.play()
        self.state = .fullScreen
        self.delegate?.didmaximize()
        self.animate()
    }
    
    @objc func newPlayerView(_ notification: Notification) {
        if let video = notification.object as? Video {
            setVideo(video: video)
            self.videoPlayerViewController.player?.play()
        } else if let pdf = notification.object as? PDF {
            setPDF(pdf: pdf)
        }
        self.state = .fullScreen
        self.delegate?.didmaximize()
        self.animate()
    }
    
    func onLikeTap() {
        refresher(updateContent: {
            () -> Void in self.content.like() }, viewReload: { () -> Void in self.tableView.reloadData()})
    }
    
    func onDisLikeTap() {
        refresher(updateContent: {
            () -> Void in self.content.dislike() }, viewReload: { () -> Void in self.tableView.reloadData()})
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
            return count + 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! headerCell
            cell.set(content: self.content, onLikeTapFunc: self.onLikeTap, onDisLikeTapFunc: self.onDisLikeTap)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Notes", for: indexPath) as! notesCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! suggestionContentCell
            cell.set(content: (self.content.suggestedContents[indexPath.row - 2]))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row <= 1) {
            return
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("open"), object: self.content.suggestedContents[indexPath.row - 1])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func returnFromPlayerView () {
        self.state = stateOfViewController.hidden
        self.animate()
        self.delegate?.didEndedSwipe(toState: self.state)
        if self.state == .hidden {
            self.videoPlayerViewController.player?.pause()
        }
    }
    
    //MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customisation()
    }
    
    func setVideo(video : Video) {
        self.content = video
        let selfVideo = self.content as! Video
        self.player.clearSubViews()
        if self.videoPlayerViewController.player == nil {
            self.videoPlayerViewController.player = AVPlayer()
        }
        self.player.addSubview(videoPlayerViewController.view)

        self.videoPlayerViewController.player?.replaceCurrentItem(with: AVPlayerItem.init(url: selfVideo.contentLink))
        if selfVideo.suggestedContents.count == 0 {
            refresher(updateContent: { () -> Void in selfVideo.fetchSuggestedContents() }, viewReload: { () -> Void in self.tableView.reloadData()})
        }
        refresher(updateContent: {() -> Void in selfVideo.fetchWikiChunkEnrichments() }, viewReload: { () -> Void in return })
        if self.state != .hidden {
            self.videoPlayerViewController.player?.play()
        }
        self.tableView.reloadData()
    }

    
    func setPDF(pdf : PDF) {
        self.content = pdf
        let selfPDF = self.content as! PDF
        self.player.clearSubViews()
        self.player.addSubview(pdfView)
        let returnButton = UIButton.init(frame: CGRect(x: 10, y: 0, width: 60, height: 35))
        returnButton.backgroundColor = UIColor.clear
        returnButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        returnButton.setTitle("< Back", for: UIControl.State.normal)
        returnButton.addTarget(nil, action: #selector(returnFromPlayerView), for: UIControl.Event.touchUpInside)
        self.player.addSubview(returnButton)
        pdfView.document = PDFDocument.init(url: selfPDF.contentLink)
        if selfPDF.suggestedContents.count == 0 {
            refresher(updateContent: { () -> Void in selfPDF.fetchSuggestedContents() }, viewReload: { () -> Void in self.tableView.reloadData()})
        }
        self.tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
