//
//  ListInteractor.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import RxSwift

protocol ListInteractoType {
    func save() -> Observable<Void>
    func getItems() -> Observable<[Item]>
}
