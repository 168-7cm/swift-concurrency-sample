//
//  UICollectionView+Xib.swift
//  FitterSDK
//
//  Created by Eisuke Arai on 2022/10/11.
//

import Foundation
import UIKit

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register(reusableViewType: UICollectionReusableView.Type, ofKind kind: String, bundle: Bundle? = nil) {
        let className = String(describing: reusableViewType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("Failed to use \(className)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(kind: String, with type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("Failed to use \(className)")
        }
        return reusableView
    }
}
