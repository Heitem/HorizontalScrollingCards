//
//  HorizontalScrollingCardsBehavior.swift
//  HorizontalScrollingCards
//
//  Created by Heitem OULED-LAGHRIYEB on 11/24/17.
//  Copyright © 2017 Hidden Founders. All rights reserved.
//

import UIKit

class HorizontalScrollingCardsFlowLayout: UICollectionViewFlowLayout {
    
    var mostRecentOffset: CGPoint = CGPoint()
    
    var d: CGFloat = 35
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if velocity.x == 0 {
            return mostRecentOffset
        }
        
        if let cv = self.collectionView {
            
            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5
            
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                
                var candidateAttributes: UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
                    if (attributes.center.x == 0) || (attributes.center.x > (cv.contentOffset.x + halfWidth) && velocity.x < 0) {
                        continue
                    }
                    candidateAttributes = attributes
                }
                
                // Beautification step , I don't know why it works!
                if proposedContentOffset.x == -(cv.contentInset.left) {
                    return proposedContentOffset
                }
                
                guard let _ = candidateAttributes else {
                    return mostRecentOffset
                }
                mostRecentOffset = CGPoint(x: floor(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
                return mostRecentOffset
                
                
            }
        }
        
        // fallback
        mostRecentOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        return mostRecentOffset
    }
}

extension HorizontalScrollingCardsFlowLayout: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let D = d + self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: indexPath.section)
        
        return CGSize(width: collectionView.frame.width - D * 2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let D = d + self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section)
        return UIEdgeInsets(top: 0, left: minimumLineSpacing, bottom: 0, right: minimumLineSpacing)
    }
}

