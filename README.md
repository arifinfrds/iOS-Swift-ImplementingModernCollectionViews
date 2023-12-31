# iOS-Swift-ImplementingModernCollectionViews
[Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)

## Tech Stack
- Modern Collection Views API
  - UICollectionViewCompositionalLayout
  - NSDiffableDataSourceSnapshot<Section, Item>
  - UICollectionView.CellRegistration<UICollectionViewListCell, Item>

## Preview
![Collection View](collectionview.png) 

## Steps
1. Create layout
```swift
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
```
2. Create your collectionView like usual, setup constraints, etc, assign layout to collectionView
```swift
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
```

3. Create your data source, including cell setup
```swift
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
```

4. Set datasource into collectionView
```swift
collectionView.dataSource = self
```

5. Set your data and reload collectionView
```swift
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
```

# References
- [Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [Adopting Collection View](https://developer.apple.com/tutorials/app-dev-training/adopting-collection-views)
