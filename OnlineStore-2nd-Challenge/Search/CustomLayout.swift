//
//  CustomLayout.swift
//  OnlineStore-2nd-Challenge
//
//  Created by user on 20.03.2025.
//

import UIKit

final class CustomLayout: UICollectionViewFlowLayout {
    
    required override init() {super.init(); common()}
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); common()}
    
    private func common() {
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
    
    override func layoutAttributesForElements(
        in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            
            guard let att = super.layoutAttributesForElements(in:rect) else {return []}
            var x: CGFloat = sectionInset.left
            var y: CGFloat = -1.0
            
            for a in att {
                if a.representedElementCategory != .cell { continue }
                
                if a.frame.origin.y >= y { x = sectionInset.left }
                a.frame.origin.x = x
                x += a.frame.width + minimumInteritemSpacing
                y = a.frame.maxY
            }
            return att
        }
}
