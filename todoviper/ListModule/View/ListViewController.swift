//
//  ListViewController.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import UIKit
import RxSwift
import RxCocoa

enum Section: CaseIterable {
    case main
}

class ListViewController: UIViewController,UICollectionViewDelegate {
    private var bag = DisposeBag()

    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    lazy var datasource: UICollectionViewDiffableDataSource<Section, Item> = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { (cell, indexPath, item) -> UICollectionViewCell in
        return self.collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: item)
    }

    lazy var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Item>  = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
        var content = cell.defaultContentConfiguration()
        content.text = item.name
        content.image = UIImage(systemName: "globe")
        cell.contentConfiguration = content
        cell.accessories = [.disclosureIndicator()]
    }

    let presenter: ListPresenterType

    init(presenter: ListPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        presenter
            .list
            .subscribe { [weak self] items in
                self?.applySnapshot(items)
            }.disposed(by: bag)

        presenter.getItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let addAction = UIAction {[weak self] action in
            self?.addItem()
        }
        let barButtonItem = UIBarButtonItem(systemItem: .add,
                                            primaryAction: addAction,
                                            menu: .none)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    private func setupView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .white
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)

        collectionView
            .rx
            .itemSelected
            .subscribe {[weak self] event in
                guard let index = event.element,
                      let item = self?.datasource.itemIdentifier(for: index) else {
                    return
                }

                self?.presenter.showDetail(id: item.id.uuidString)
            }.disposed(by: bag)
    }

    func applySnapshot(_ items: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(items)

        datasource.apply(snapshot)
    }

    func addItem() {
        presenter.save(.init(name: "New Item"))
    }
}
