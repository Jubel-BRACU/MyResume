//
//  UICollectionView+Extensions.swift
//  MyResume
//
//  Created by Simon Italia on 12/21/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewController {
    
    //Define / configure and create UICollectionView compositional layout
    func setupLayoutOne() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(320),
                                               heightDimension: .absolute(170)),
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)

        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        headerView.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [headerView]

        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0,
                                                        leading: 0.0,
                                                        bottom: 5.0,
                                                        trailing: 0.0)

        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return section
    }
    
    
    func setupLayoutTwo() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))) // This height does not have any effect. Bug?
        
          item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0)
//        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
//            leading: NSCollectionLayoutSpacing.flexible(0.0),
//            top: NSCollectionLayoutSpacing.flexible(0.0),
//            trailing: NSCollectionLayoutSpacing.flexible(0.0),
//            bottom: NSCollectionLayoutSpacing.flexible(0.0))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(320),
            heightDimension: .absolute(170)),
//            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .fractionalHeight(1.0)),
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)),
            
//            layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(1.0),
//                                               heightDimension: .absolute(44)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        headerView.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [headerView]
        
//        section.interGroupSpacing = 20
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 5.0,
                                                        leading: 0.0,
                                                        bottom: 5.0,
                                                        trailing: 0.0)
        return section
    }
    
        
}
    
    

