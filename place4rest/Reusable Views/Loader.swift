//
//  LoadingView.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

public class Loader {

    static private var shared: Loader = .init()

    private var size: Double = 70.0

    fileprivate lazy var spinnerView: SpinnerView = {
        let view = SpinnerView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        view.spinnerColor = R.color.green()!
        view.lineWidth = 5
        return view
    }()

    private init() {}
}

// MARK: - Public
extension Loader {

    static var animating: Bool {
        return shared.spinnerView.superview == frontWindow
    }

    static public func show() {
        guard !animating, let frontWindow = frontWindow else { return }
        shared.spinnerView.center = frontWindow.center
        frontWindow.addSubview(shared.spinnerView)
        shared.spinnerView.animate()
    }

    static public func hide() {
        guard animating else { return }
        shared.spinnerView.removeFromSuperview()
        shared.spinnerView.stopAnimating()
    }
}

// MARK: - Private
extension Loader {
    fileprivate static var frontWindow: UIWindow? {
        return UIApplication.shared.windows.reversed().first(where: {
            return $0.screen == UIScreen.main
                && $0.windowLevel <= .normal
                && !$0.isHidden && $0.alpha > 0
                && $0.isKeyWindow
        })
    }
}
