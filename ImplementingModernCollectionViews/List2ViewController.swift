import SwiftUI
import UIKit

struct Item: Hashable {
    let text: String
    let secondaryText: String
    let imageName: String
}

final class List2ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupList()
        applyInitialSnapshot()
    }
    
    private func setupList() {
        layout = makeLayout()
        
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
        let imageNames = ["triangle.fill", "rectangle.fill", "circle.fill", "oval.fill"]
        
        let items0 = (1...1000)
            .map { String($0) }
            .map { Item(text: "item name: \($0)", secondaryText: UUID().uuidString, imageName: imageNames.randomElement() ?? "triangle.fill") }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items0, toSection: 0)
        
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

struct List2ViewPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> List2ViewController {
        List2ViewController()
    }
    
    func updateUIViewController(_ uiViewController: List2ViewController, context: Context) { }
}

struct List2View: View {
    var body: some View {
        List2ViewPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct List2View_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            List2View()
            List2View()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
