//
//  Reactive+Error.swift
//  FlickrImageSearch
//
//  Created by xWARE on 5/3/20.
//  Copyright © 2020 xWARE. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController: errorViewable {}

extension Reactive where Base: UIViewController {

    /// Bindable sink for isError() method.
    public var isError: Binder<ErrorMessage> {
        return Binder(self.base, binding: { (viewController, error) in
            viewController.showError(with: error)
        })
    }
}

protocol errorViewable {
    func showError(with: ErrorMessage)
}
extension errorViewable where Self: UIViewController {
    func showError(with: ErrorMessage) {
        let alertController =
            UIAlertController(title: with.title, message: with.message, preferredStyle: UIAlertController.Style.alert)
        let okAction =
            UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
            if let action = with.action {
                action()
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

public struct ErrorMessage {
    let title: String?
    let message: String?
    let action: (() -> Void)?
}
