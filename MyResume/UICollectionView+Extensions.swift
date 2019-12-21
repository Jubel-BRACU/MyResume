//
//  UICollectionView+Extensions.swift
//  MyResume
//
//  Created by Simon Italia on 12/21/19.
//  Copyright © 2019 SDI Group Inc. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

//Define / configure and create UICollectionView compositional layout
    func setUpCompositionLayout() -> UICollectionViewCompositionalLayout {

        //Define Layout
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            //Define Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 5.0, bottom: 0.0, trailing: 5.0)
            
            //Define Group
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(300), //was .estimated(250)
                heightDimension: .absolute(150)), //was 170
                subitem: item,
                count: 1)
            
            //Define Section
            let section = NSCollectionLayoutSection(group: group)
            
            //Define Section header
            let headerView = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(1.0)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
            headerView.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [headerView]
            section.contentInsets = NSDirectionalEdgeInsets(top: 5.0,
                                                            leading: 0.0,
                                                            bottom: 16.0,
                                                            trailing: 0.0)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        }
        
        return layout
    }
}
