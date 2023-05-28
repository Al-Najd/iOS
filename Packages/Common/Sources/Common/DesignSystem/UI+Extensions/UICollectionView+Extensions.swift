//
//  UICollectionView+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 27/09/2022.
//

import UIKit

public extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("⚠️ Unable to dequeue cell type: \(T.self) at indexPath: \(indexPath)")
        }
        return cell
    }

    func register(_ klass: AnyClass, identifier: String? = nil) {
        let nibName = String(describing: klass.self)
        let identifier = identifier ?? nibName
        let nib = UINib(nibName: nibName, bundle: .init(for: klass))
        register(nib, forCellWithReuseIdentifier: identifier)
    }

    func cellAt<T>(indexPath: IndexPath) -> T? {
        let cell = cellForItem(at: indexPath) as? T
        return cell
    }
}
