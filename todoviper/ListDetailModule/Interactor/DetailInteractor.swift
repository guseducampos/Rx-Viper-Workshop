//
//  DetailInteractor.swift
//  todoviper
//
//  Created by Gustavo Campos on 6/10/20.
//

import Foundation
import RxSwift

protocol DetailsInteractorType {
    func getDetailsInformation(id: String) -> Observable<Item>
}

struct DetailsInteractor: DetailsInteractorType {
    func getDetailsInformation(id: String) -> Observable<Item> {
        return Observable.just(Item(id: .init(), name: "Test"))
    }
}
