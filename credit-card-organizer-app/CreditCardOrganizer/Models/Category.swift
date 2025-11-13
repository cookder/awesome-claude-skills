import Foundation

struct Category: Identifiable, Codable {
    let id: UUID
    let name: String
    let icon: String // SF Symbol name
    let color: String // Hex color

    init(id: UUID = UUID(), name: String, icon: String, color: String) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
    }

    static let defaultCategories: [Category] = [
        Category(name: "Groceries", icon: "cart.fill", color: "#34C759"),
        Category(name: "Dining", icon: "fork.knife", color: "#FF9500"),
        Category(name: "Transportation", icon: "car.fill", color: "#007AFF"),
        Category(name: "Entertainment", icon: "tv.fill", color: "#AF52DE"),
        Category(name: "Shopping", icon: "bag.fill", color: "#FF2D55"),
        Category(name: "Bills & Utilities", icon: "bolt.fill", color: "#FFCC00"),
        Category(name: "Subscriptions", icon: "repeat.circle.fill", color: "#5856D6"),
        Category(name: "Healthcare", icon: "cross.case.fill", color: "#FF3B30"),
        Category(name: "Travel", icon: "airplane", color: "#00C7BE"),
        Category(name: "Gas", icon: "fuelpump.fill", color: "#8E8E93"),
        Category(name: "Other", icon: "ellipsis.circle.fill", color: "#C7C7CC")
    ]
}
