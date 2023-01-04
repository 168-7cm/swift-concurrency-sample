//
//  UITableView+Xib.swift
//  FitterSDK
//
//  Created by Eisuke Arai on 2022/10/11.
//

import Foundation
import UIKit

extension UITableView {
    func register(cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register(headerFooterType: UITableViewHeaderFooterView.Type, bundle: Bundle? = nil) {
        let className = String(describing: headerFooterType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }


    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("Failed to use \(className)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        let className = String(describing: type)
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: className) as? T else {
            fatalError("Failed to use \(className)")
        }
        return headerFooter
    }
}
