//
//  DetailPresenter.swift
//  todoviper
//
//  Created by Gustavo Campos on 6/10/20.
//

import Foundation
import RxSwift

protocol DetailPresenterType: class {
    func item() -> Observable<Item>
}

final class DetailPresenter: DetailPresenterType {
    let interactor: DetailsInteractorType
    let id: String

    init(interactor: DetailsInteractorType,
         id: String) {
        self.interactor = interactor
        self.id = id
    }
    
    func item() -> Observable<Item> {
        interactor.getDetailsInformation(id: id)
    }
}
