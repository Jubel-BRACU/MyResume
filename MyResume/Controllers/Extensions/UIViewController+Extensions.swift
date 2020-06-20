//
//  UIViewController+Extensions.swift
//  MyResume
//
//  Created by Simon Italia on 6/20/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

//MARK: - UICollectionviewCompositionalLayout

extension UIViewController {
    
    //MARK: - Experience + iOS Projects UICollectionViews
    
    func setupExperienceAndProjectsLayout() -> NSCollectionLayoutSection {

        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        headerView.pinToVisibleBounds = true

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))

        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 8.0, trailing: 8.0)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(320), heightDimension: .estimated(340)), subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0,leading: 0.0,bottom: 0.0,trailing: 0.0)
        section.boundarySupplementaryItems = [headerView]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return section
    }

    
    //MARK: - Education + Training UICollectionViews

    func setupEducationAndTrainingLayout() -> NSCollectionLayoutSection {
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        headerView.pinToVisibleBounds = true

        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(0.5))) // This height does not have any effect. Bug?
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 8.0, trailing: 8.0)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(320),
            heightDimension: .absolute(340)), subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0,bottom: 0.0,trailing: 0.0)
        section.boundarySupplementaryItems = [headerView]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return section
    }
}
