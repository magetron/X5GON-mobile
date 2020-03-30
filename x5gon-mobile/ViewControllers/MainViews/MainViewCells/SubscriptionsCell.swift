//
//  SubscriptionsCell.swift
//  x5gon-mobile
//
//  Created by Patrick Wu on 19/02/2020.
//  Copyright © 2020 x5gon. All rights reserved.
//
//import Foundation
//import UIKit
//
//// Custom Classes
//class SubscriptionsCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
//    //MARK: - Properties
//    ///This is a `collectionView` which is used to display the Subscrption View
//    @IBOutlet weak var collectionView: UICollectionView!
//    ///This variable is used to store a list of self-defined type `Channel`
//    var channels = [Channel]()
//    
//    //MARK: - Methods
//    ///Customise collectionView
//    func customisation() {
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
//        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        self.channels = Channel.generateDefaultChannels()
//        self.collectionView.reloadData()
//    }
//    
//    //MARK: - Delegates
//    /**
//     Asks collectionView for the number of items in the specified section.
//     
//     - Parameters:
//        - collectionView: The collection view requesting this information.
//        - section: An index number identifying a section in collectionView. This index value is 0-based.
//     - returns:
//     The number of rows in section.
//     
//     */
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.channels.count
//    }
//    
//    /**
//     Asks  channel variable  for the cell that corresponds to the specified item in the collection view.
//     
//     - Parameters:
//        - collectionView: The collection view requesting this information.
//        - indexPath: The index path that specifies the location of the item.
//     - returns:
//     A configured cell object. You must not return nil from this method.
//     
//     */
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelModel", for: indexPath) as! SubscriptionsCVCell
//        cell.channelPic.image = self.channels[indexPath.row].image
//        return cell
//    }
//    
//    /**
//     Asks the delegate for the size of the specified item’s cell.
//     
//     - Parameters:
//        - collectionView: The collection view object displaying the flow layout.
//        - indexPath: The index path of the item
//        - collectionViewLayout:The layout object requesting the
//     - returns:
//     The width and height of the specified item. Both values must be greater than 0.
//     
//     */
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: 50, height: 50)
//    }
//    
//    //MARK: - View Lifecycle
//    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file. And load `customisation` Method
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.customisation()
//    }
//}
