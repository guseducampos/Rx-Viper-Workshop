//
//  ListPresenter.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import RxSwift

protocol ListPresenter {
    var list: Observable<[Item]> { get }
}

