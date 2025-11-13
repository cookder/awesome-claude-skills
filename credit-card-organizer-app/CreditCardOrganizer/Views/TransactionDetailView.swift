import SwiftUI
import SwiftData

struct TransactionDetailView: View {
    @Bindable var transaction: Transaction
    @Environment(\.modelContext) private var modelContext

    @State private var isEditingCategory = false
    @State private var isEditingType = false

    var body: some View {
        List {
            Section("Details") {
                DetailRow(label: "Merchant", value: transaction.merchant)
                DetailRow(label: "Amount", value: "$\(transaction.amount, specifier: "%.2f")")
                DetailRow(label: "Date", value: transaction.date.formatted(date: .long, time: .omitted))

                if let card = transaction.card {
                    DetailRow(label: "Card", value: "\(card.name) •••• \(card.lastFourDigits)")
                }
            }

            Section("Categorization") {
                // Category picker
                HStack {
                    Text("Category")
                        .foregroundColor(.primary)
                    Spacer()
                    Picker("Category", selection: $transaction.category) {
                        ForEach(Category.defaultCategories) { category in
                            HStack {
                                Image(systemName: category.icon)
                                Text(category.name)
                            }
                            .tag(category.name)
                        }
                    }
                    .pickerStyle(.menu)
                }

                // Transaction type picker
                HStack {
                    Text("Type")
                        .foregroundColor(.primary)
                    Spacer()
                    Picker("Type", selection: $transaction.transactionType) {
                        ForEach(TransactionType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }

            if !transaction.transactionDescription.isEmpty {
                Section("Description") {
                    Text(transaction.transactionDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if transaction.isRecurringCandidate {
                Section {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.blue)
                        Text("This appears to be a recurring charge")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Transaction Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    NavigationStack {
        TransactionDetailView(transaction: Transaction(
            date: Date(),
            merchant: "Starbucks",
            amount: 5.75,
            description: "Coffee purchase",
            category: "Dining"
        ))
    }
    .modelContainer(for: [Transaction.self, CreditCard.self])
}
