//
//  DataManager.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import RxSwift
import RxCocoa

protocol DataManagerType {
    func fetchItems() -> Observable<[Item]>
    func addItem(_ item: Item) -> Observable<Void>
}

struct DataManager: DataManagerType {
    func fetchItems() -> Observable<[Item]> {
        let userDefaults = UserDefaults.standard
        let data = userDefaults.data(forKey: "Items") ?? Data()
        let items: [Item] = (try? JSONDecoder().decode([Item].self, from: data)) ?? []
        return Observable.just(items)
    }

    func addItem(_ item: Item) -> Observable<Void> {
        let userDefaults = UserDefaults.standard
        let data = userDefaults.data(forKey: "Items") ?? Data()
        var items: [Item] = (try? JSONDecoder().decode([Item].self, from: data)) ?? []
        items.append(item)
        let newData = try! JSONEncoder().encode(items)
        userDefaults.set(newData, forKey: "Items")
        return Observable.create { observer in
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
