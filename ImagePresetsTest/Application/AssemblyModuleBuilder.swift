//
//  ModuleBuilder.swift
//  ImagePresetsTest
//
//  Created by Egor Syrtcov on 14.01.22.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
   
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = Main()
        let dependencies = Dependencies()
        let presenter = MainPresenter(view: view, router: router, dependencies: dependencies)
        view.presenter = presenter
        return view
    }
}
