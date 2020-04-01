//
//  VideoPlayerView.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 13/01/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//

protocol PlayerViewControllerDelegate {
    /// Did the `playerView` minimised
    func didMinimize()
    // Did the `playerView` extended
    func didmaximize()
    func swipeToMinimize(translation: CGFloat, toState: stateOfViewController)
    func didEndedSwipe(toState: stateOfViewController)
    func setPreferStatusBarHidden(_ preferHidden: Bool)
}

import AVFoundation
import AVKit
import JGProgressHUD
import PDFKit
import UIKit

class PlayerView: UIView, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, PlayerViewHeaderCellDelegate {
    // MARK: -  Properties

    @IBOutlet var tableView: UITableView!
    @IBOutlet var player: UIView!
    @IBOutlet var navigationView: playerNavigationView!
    var content: Content!
    var delegate: PlayerViewControllerDelegate?
    var state = stateOfViewController.hidden
    var direction = Direction.none
    var pdfView = PDFView()
    let videoPlayerViewController = AVPlayerViewController()
    var contentLiked = false
    var contentDisliked = false

    // MARK: - Methods

    func customisation() {
        addSubview(navigationView)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: navigationView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: navigationView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: navigationView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: navigationView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        navigationView.isHidden = true

        backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90

        player.layer.shadowOpacity = 1
        player.layer.shadowOffset = .zero
        player.layer.anchorPoint.applying(CGAffineTransform(translationX: -0.5, y: -0.5))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        player.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resumePlayerView)))
        videoPlayerViewController.view.frame = player.frame
        videoPlayerViewController.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPlayerViewController.showsPlaybackControls = true
        pdfView.frame = player.frame
        pdfView.displayMode = PDFDisplayMode.singlePage

        NotificationCenter.default.addObserver(self, selector: #selector(newPlayerView), name: NSNotification.Name("open"), object: nil)
    }

    @IBAction func showNavigation(_: Any) {
        navigationView.isHidden = false
        navigationView.tableView.center.x += navigationView.bounds.width
        UIView.animate(withDuration: 0.6) {
            self.navigationView.backgroundView.alpha = 0.5
            self.navigationView.tableView.center.x -= self.navigationView.bounds.width
        }
    }

    func animate() {
        switch state {
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
                let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
                let trasform = scale.concatenating(CGAffineTransform(translationX: -self.player.bounds.width / 4, y: -self.player.bounds.height / 4))
                self.player.transform = trasform
                })
        default: break
        }
    }

    func changeValues(scaleFactor: CGFloat) {
        tableView.alpha = 1 - scaleFactor
        let scale = CGAffineTransform(scaleX: 1 - 0.5 * scaleFactor, y: 1 - 0.5 * scaleFactor)
        let trasform = scale.concatenating(CGAffineTransform(translationX: -(player.bounds.width / 4 * scaleFactor), y: -(player.bounds.height / 4 * scaleFactor)))
        player.transform = trasform
    }

    @objc func resumePlayerView() {
        if let _ = content as? Video {
            videoPlayerViewController.player?.play()
        }
        state = .fullScreen
        delegate?.didmaximize()
        animate()
    }

    @objc func newPlayerView(_ notification: Notification) {
        let content = notification.object as! Content
        if content == self.content {
            return resumePlayerView()
        }
        MainController.Queue.cancelOperations() // for performance concerns
        state = .fullScreen
        delegate?.didmaximize()
        animate()
        setContent(content: content)
        MainController.addHistory(content: content)
    }

    func onLikeTap(completion: @escaping () -> Void) {
        if !contentLiked {
            refresherWithLoadingHUD(updateContent: {
                () -> Void in self.content.like()
            }, viewReload: { () -> Void in completion(); self.tableView.reloadDataWithAnimation() }, view: tableView, cancellable: false)
            contentLiked = true
        } else {
            refresherWithLoadingHUD(updateContent: {
                () -> Void in self.content.unlike()
            }, viewReload: { () -> Void in completion(); self.tableView.reloadDataWithAnimation() }, view: tableView, cancellable: false)
            contentLiked = false
        }
    }

    func onDisLikeTap(completion: @escaping () -> Void) {
        if !contentDisliked {
            refresherWithLoadingHUD(updateContent: {
                () -> Void in self.content.dislike()
            }, viewReload: { () -> Void in completion(); self.tableView.reloadDataWithAnimation() }, view: tableView, cancellable: false)
            contentDisliked = true
        } else {
            refresherWithLoadingHUD(updateContent: {
                () -> Void in self.content.undislike()
            }, viewReload: { () -> Void in completion(); self.tableView.reloadDataWithAnimation() }, view: tableView, cancellable: false)
            contentDisliked = false
        }
    }

    @IBAction func minimizeGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            let velocity = sender.velocity(in: nil)
            if abs(velocity.x) < abs(velocity.y) {
                direction = .up
            } else {
                direction = .left
            }
        }
        var finalState = stateOfViewController.fullScreen
        switch state {
        case .fullScreen:
            let factor = (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
            changeValues(scaleFactor: factor)
            delegate?.swipeToMinimize(translation: factor, toState: .minimized)
            finalState = .minimized
        case .minimized:
            if direction == .left {
                finalState = .hidden
                let factor: CGFloat = sender.translation(in: nil).x
                delegate?.swipeToMinimize(translation: factor, toState: .hidden)
            } else {
                finalState = .fullScreen
                let factor = 1 - (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
                changeValues(scaleFactor: factor)
                delegate?.swipeToMinimize(translation: factor, toState: .fullScreen)
            }
        default: break
        }
        if sender.state == .ended {
            state = finalState
            animate()
            delegate?.didEndedSwipe(toState: state)
            if state == .hidden {
                videoPlayerViewController.player?.pause()
            }
        }
    }

    func setContent(content: Content) {
        self.content = content
        contentLiked = false
        contentDisliked = false
        if let video = content as? Video {
            setVideo(video: video)
        } else if let pdf = content as? PDF {
            setPDF(pdf: pdf)
        }
        if content.suggestedContents.count == 0 {
            refresherWithLoadingHUD(updateContent: { () -> Void in
                content.fetchSuggestedContents()
            }, viewReload: { () -> Void in
                if self.content == content {
                    self.tableView.reloadDataWithAnimation()
                }
            }, view: tableView, cancellable: true)
        }
        if content.wiki.chunks.count == 0 {
            refresherWithLoadingHUD(updateContent: { () -> Void in content.fetchWikiChunkEnrichments() }, viewReload: { () -> Void in
                if self.content.hashValue == content.hashValue {
                    self.navigationView.setWiki(wiki: content.wiki)
                    self.navigationView.tableView.reloadDataWithAnimation()
                }
            }, view: navigationView.tableView, cancellable: true)
        }
        tableView.reloadDataWithAnimation()
    }

    func setVideo(video: Video) {
        player.clearSubViews()
        if videoPlayerViewController.player == nil {
            videoPlayerViewController.player = AVPlayer()
        }
        player.addSubview(videoPlayerViewController.view)
        if video.avPlayerItem != nil {
            videoPlayerViewController.player?.replaceCurrentItem(with: video.avPlayerItem)
        } else {
            video.avPlayerItem = AVPlayerItem(url: video.contentLink)
            videoPlayerViewController.player?.replaceCurrentItem(with: video.avPlayerItem)
        }
        if state != .hidden {
            videoPlayerViewController.player?.play()
        }
        // self.videoPlayerViewController.player?.pause()
    }

    func setPDF(pdf: PDF) {
        player.clearSubViews()
        player.addSubview(pdfView)
        let returnButton = UIButton(frame: CGRect(x: 5, y: 16, width: 60, height: 35))
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: player.bounds.width, height: 54))
        returnButton.backgroundColor = UIColor.clear
        returnButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        returnButton.setTitle("Back", for: UIControl.State.normal)
        returnButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        returnButton.addTarget(nil, action: #selector(returnFromPlayerView), for: UIControl.Event.touchUpInside)
        player.addSubview(navBar)
        player.addSubview(returnButton)
        pdfView.document = PDFDocument(url: pdf.contentLink)
    }

    // MARK: - Delegate

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if let count = content?.suggestedContents.count {
            return count + 2
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! headerCell
            cell.set(content: content, onLikeTapFunc: onLikeTap, onDisLikeTapFunc: onDisLikeTap)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Notes", for: indexPath) as! notesCell
            cell.set(text: MainController.getNotes(id: content.id), id: content.id)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! suggestionContentCell
            cell.set(content: content.suggestedContents[indexPath.row - 2])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row <= 1 {
            return
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("open"), object: content.suggestedContents[indexPath.row - 2])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 ... 1:
            return UITableView.automaticDimension
        default:
            return 110
        }
    }

    @objc func returnFromPlayerView() {
        state = stateOfViewController.hidden
        animate()
        delegate?.didEndedSwipe(toState: state)
        if state == .hidden {
            videoPlayerViewController.player?.pause()
        }
    }

    // MARK: - View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        customisation()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
