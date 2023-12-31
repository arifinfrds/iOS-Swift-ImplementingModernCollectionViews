import Foundation

protocol ItemLoader {
    func load() -> [Item]
}

struct StubItemLoader: ItemLoader {
    func load() -> [Item] {
        let imageNames = ["triangle.fill", "rectangle.fill", "circle.fill", "oval.fill"]
        
        let items = (1...1000)
            .map { String($0) }
            .map { Item(text: "item name: \($0)", secondaryText: UUID().uuidString, imageName: imageNames.randomElement() ?? "triangle.fill") }
        
        return items
    }
}
