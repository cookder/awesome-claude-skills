import Foundation
import SwiftData

@Model
final class CreditCard {
    var id: UUID
    var name: String
    var lastFourDigits: String
    var cardType: String // Visa, Mastercard, Amex, etc.
    var color: String // Hex color for UI
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Transaction.card)
    var transactions: [Transaction]?

    init(
        id: UUID = UUID(),
        name: String,
        lastFourDigits: String,
        cardType: String,
        color: String = "#007AFF",
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.lastFourDigits = lastFourDigits
        self.cardType = cardType
        self.color = color
        self.createdAt = createdAt
    }
}
