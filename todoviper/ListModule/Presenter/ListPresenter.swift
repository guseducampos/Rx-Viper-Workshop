//
//  ListPresenter.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import RxSwift
import RxCocoa

protocol ListPresenterType: class {
    var list: Observable<[Item]> { get }
    func save(_ item: Item)
    func getItems()
    func showDetail(id: String)
}


final class ListPresenter: ListPresenterType {
    private var bag = DisposeBag()
    let interactor: ListInteractorType
    let wireFrame: ListModuleWireFrame

    var list: Observable<[Item]> {
        listItems.asObservable()
    }

    private var listItems: BehaviorRelay<[Item]> = .init(value: [])

    init(interactor: ListInteractorType,
         wireFrame: ListModuleWireFrame) {
        self.interactor = interactor
        self.wireFrame = wireFrame
    }

    func save(_ item: Item) {
        interactor
            .save(item)
            .withLatestFrom(listItems)
            .map { items -> [Item] in
                var items = items
                items.append(item)
                return items
            }
            .subscribe {[weak self] items in
                self?.listItems.accept(items)
            }
            .disposed(by: bag)

    }

    func getItems() {
        interactor
            .getItems()
            .subscribe {[weak self] in
                self?.listItems.accept($0)
            }
            .disposed(by: bag)
    }

    func showDetail(id: String) {
        wireFrame.navigateToDetail(id: id)
    }
}
