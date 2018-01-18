//
//  CategoryRow.swift
//  AlgorithmHelper
//
//  Created by Eric Liu on 2018-01-17.
//  Copyright © 2018 Eric Liu. All rights reserved.
//

import UIKit

class CategoryRow: UITableViewCell {
    var index = 0
    var parent: ExploreViewController?
}

// MARK: - Configure CategoryRow as the UICollectionViewDataSource
extension CategoryRow: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ContentSingleton.instance().getCategoryList()[self.index].topicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as! TopicCollectionViewCell
        cell.topicLabel.text = ContentSingleton.instance().getCategoryList()[self.index].topicList[indexPath.row].title
        cell.topicImageView.image = UIImage(named: ContentSingleton.instance().getCategoryList()[self.index].topicList[indexPath.row].image)
        cell.topicImageView.layer.cornerRadius = 5
        cell.topicImageView.clipsToBounds = true
        return cell
    }
}

// MARK: - Configure CategoryRow as the UICollectionViewDelegateFlowLayout
extension CategoryRow: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = 150
        let itemHeight = 150
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

// MARK: - Configure CategoryRow as the UICollectionViewDelegate
extension CategoryRow: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        parent?.performSegueToTopicViewController(categoryIndex: index, topicIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TopicCollectionViewCell
        cell.topicImageView.layer.opacity = 0.75
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TopicCollectionViewCell
        cell.topicImageView.layer.opacity = 1
    }
}

