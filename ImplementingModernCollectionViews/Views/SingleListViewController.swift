import SwiftUI
import UIKit

final class SingleListViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private let loader: any ItemLoader
    
    init(loader: some ItemLoader) {
        self.loader = loader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupList()
        applyInitialSnapshot()
    }
    
    private func setupList() {
        let layout = makeLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = dataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func applyInitialSnapshot() {
        let items = loader.load()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, Item> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = item.text
            contentConfiguration.image = UIImage(systemName: item.imageName)
            contentConfiguration.secondaryText = item.secondaryText
            contentConfiguration.secondaryTextProperties.color = .secondaryLabel
            cell.contentConfiguration = contentConfiguration
            cell.accessories = [ .disclosureIndicator() ]
        }
        
        return UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }()
}

struct SingleListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SingleListViewController {
        SingleListViewController(loader: StubItemLoader())
    }
    
    func updateUIViewController(_ uiViewController: SingleListViewController, context: Context) { }
}

struct SingleListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SingleListView()
            SingleListView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
