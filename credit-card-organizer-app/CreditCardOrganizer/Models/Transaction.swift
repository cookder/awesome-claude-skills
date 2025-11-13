import Foundation
import SwiftData

enum TransactionType: String, Codable, CaseIterable {
    case single = "Single"
    case recurring = "Recurring"
    case subscription = "Subscription"
}

@Model
final class Transaction {
    var id: UUID
    var date: Date
    var merchant: String
    var amount: Double
    var transactionDescription: String
    var category: String
    var transactionType: TransactionType
    var isRecurringCandidate: Bool // For detecting potential recurring charges

    var card: CreditCard?

    init(
        id: UUID = UUID(),
        date: Date,
        merchant: String,
        amount: Double,
        description: String = "",
        category: String = "Uncategorized",
        transactionType: TransactionType = .single,
        isRecurringCandidate: Bool = false
    ) {
        self.id = id
        self.date = date
        self.merchant = merchant
        self.amount = amount
        self.transactionDescription = description
        self.category = category
        self.transactionType = transactionType
        self.isRecurringCandidate = isRecurringCandidate
    }
}
