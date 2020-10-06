//
//  ListInteractor.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import RxSwift

protocol ListInteractorType {
    func save(_ item: Item) -> Observable<Void>
    func getItems() -> Observable<[Item]>
}


struct ListInteractor: ListInteractorType {
    let dataManager: DataManagerType

    func save(_ item: Item) -> Observable<Void> {
        dataManager.addItem(item)
    }

    func getItems() -> Observable<[Item]> {
        dataManager.fetchItems()
    }
}
