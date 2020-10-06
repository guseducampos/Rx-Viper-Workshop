//
//  ListModuleWireFrame.swift
//  todoviper
//
//  Created by Gustavo Campos on 6/10/20.
//

import UIKit

final class ListModuleWireFrame {
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func navigateToDetail(id: String) {
        let interactor = DetailsInteractor()
        let presenter = DetailPresenter(interactor: interactor, id: id)
        let viewController = DetailViewController(presenterType: presenter)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
