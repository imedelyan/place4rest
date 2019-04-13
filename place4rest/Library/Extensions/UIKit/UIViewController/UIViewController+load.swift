//
//  UIViewController+load.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

extension UIViewController: StoryboardLoadable {}

protocol StoryboardLoadable: class {
    static func load(from storyboard: AppStoryboard) -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    static func load(from storyboard: AppStoryboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vcId = NSStringFromClass(self).components(separatedBy: ".").last!
        return storyboard.instantiateViewController(withIdentifier: vcId) as! Self
    }
}
