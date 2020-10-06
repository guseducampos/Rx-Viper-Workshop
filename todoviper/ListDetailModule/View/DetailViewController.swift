//
//  DetailViewController.swift
//  todoviper
//
//  Created by Gustavo Campos on 6/10/20.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    let presenterType: DetailPresenterType

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bag = DisposeBag()

    init(presenterType: DetailPresenterType) {
        self.presenterType = presenterType

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 40)
        ])

        presenterType
            .item()
            .bind {[weak self] item in
                self?.titleLabel.text = item.name
        }.disposed(by: bag)
    }
}
