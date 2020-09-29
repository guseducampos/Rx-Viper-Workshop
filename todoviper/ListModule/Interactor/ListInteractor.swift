//
//  ListInteractor.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import RxSwift

protocol ListInteractorType {
    func save() -> Observable<Void>
    func getItems() -> Observable<[Item]>
}
