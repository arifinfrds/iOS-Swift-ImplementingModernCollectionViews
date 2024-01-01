import UIKit
import SwiftUI

class SingleListPortraitTwoGridsLandscapeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupListOrientation()
    }
    
    private func setupListOrientation() {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        
        let orientation = sceneDelegate.window?.windowScene?.interfaceOrientation ?? .portrait
        layout = orientation.isPortrait || orientation == .unknown
        ? createSingleColumnLayout()
        : createTwoColumnLayout()
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setupList() {
        layout = createSingleColumnLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    private func createSingleColumnLayout() -> UICollectionViewLayout {
        let height: Double = 0.5
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createTwoColumnLayout() -> UICollectionViewLayout {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = .fixed(5)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // Layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension SingleListPortraitTwoGridsLandscapeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

extension SingleListPortraitTwoGridsLandscapeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item :\(indexPath)")
    }
}

struct SingleListPortraitTwoGridsLandscapeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SingleListPortraitTwoGridsLandscapeViewController {
        SingleListPortraitTwoGridsLandscapeViewController()
    }
    
    func updateUIViewController(_ uiViewController: SingleListPortraitTwoGridsLandscapeViewController, context: Context) { }
}


struct SingleListPortraitTwoGridsHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SingleListPortraitTwoGridsLandscapeView()
            SingleListPortraitTwoGridsLandscapeView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
