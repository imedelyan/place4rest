//
//  SwinjectStoryboard+Assembler.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        _ = Assembler([
            NavigatorsAssembly(),
            ViewControllersAssembly(),
            PresentersAssembly(),
            NetworkServicesAssembly(),
            NetworkAPIsAssembly(),
            UtilitiesServicesAssembly()
            ], container: defaultContainer)
    }
}
