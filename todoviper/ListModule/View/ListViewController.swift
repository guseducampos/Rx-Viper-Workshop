//
//  ListViewController.swift
//  todoviper
//
//  Created by Gustavo Campos on 29/9/20.
//

import UIKit

enum Section: CaseIterable {
    case main
}

class ListViewController: UIViewController {
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


    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        applySnapshot()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let addAction = UIAction { action in

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
    }

    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([])

        datasource.apply(snapshot)
    }
}
