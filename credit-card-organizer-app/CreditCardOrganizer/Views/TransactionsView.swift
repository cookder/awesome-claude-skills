import SwiftUI
import SwiftData

struct TransactionsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Transaction.date, order: .reverse) private var transactions: [Transaction]

    @State private var searchText = ""
    @State private var selectedFilter: FilterOption = .all
    @State private var selectedCategory = "All"

    enum FilterOption: String, CaseIterable {
        case all = "All"
        case single = "Single"
        case recurring = "Recurring"
        case subscription = "Subscription"
    }

    var filteredTransactions: [Transaction] {
        transactions.filter { transaction in
            let matchesSearch = searchText.isEmpty ||
                transaction.merchant.localizedCaseInsensitiveContains(searchText) ||
                transaction.category.localizedCaseInsensitiveContains(searchText)

            let matchesFilter: Bool
            switch selectedFilter {
            case .all:
                matchesFilter = true
            case .single:
                matchesFilter = transaction.transactionType == .single
            case .recurring:
                matchesFilter = transaction.transactionType == .recurring
            case .subscription:
                matchesFilter = transaction.transactionType == .subscription
            }

            let matchesCategory = selectedCategory == "All" ||
                transaction.category == selectedCategory

            return matchesSearch && matchesFilter && matchesCategory
        }
    }

    var allCategories: [String] {
        let categories = Set(transactions.map { $0.category })
        return ["All"] + categories.sorted()
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Filter pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(FilterOption.allCases, id: \.self) { filter in
                            FilterPill(
                                title: filter.rawValue,
                                isSelected: selectedFilter == filter
                            ) {
                                selectedFilter = filter
                            }
                        }

                        Divider()
                            .frame(height: 20)

                        ForEach(allCategories, id: \.self) { category in
                            FilterPill(
                                title: category,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color(.systemBackground))

                if filteredTransactions.isEmpty {
                    ContentUnavailableView(
                        "No Transactions",
                        systemImage: "creditcard",
                        description: Text("Upload a statement to see your transactions")
                    )
                } else {
                    List {
                        ForEach(filteredTransactions) { transaction in
                            NavigationLink(destination: TransactionDetailView(transaction: transaction)) {
                                TransactionRow(transaction: transaction)
                            }
                        }
                        .onDelete(perform: deleteTransactions)
                    }
                    .listStyle(.plain)
                    .searchable(text: $searchText, prompt: "Search transactions")
                }
            }
            .navigationTitle("Transactions")
        }
    }

    private func deleteTransactions(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredTransactions[index])
        }
    }
}

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 12) {
            // Category icon
            ZStack {
                Circle()
                    .fill(categoryColor.opacity(0.2))
                    .frame(width: 44, height: 44)

                Image(systemName: categoryIcon)
                    .foregroundColor(categoryColor)
                    .font(.system(size: 18))
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(transaction.merchant)
                        .font(.headline)

                    if transaction.transactionType != .single {
                        Image(systemName: "repeat.circle.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                }

                HStack(spacing: 8) {
                    Text(transaction.category)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("•")
                        .foregroundColor(.secondary)
                        .font(.caption)

                    Text(transaction.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if let card = transaction.card {
                        Text("•")
                            .foregroundColor(.secondary)
                            .font(.caption)

                        Text("•••• \(card.lastFourDigits)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

            Spacer()

            Text("$\(transaction.amount, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(transaction.amount < 0 ? .green : .primary)
        }
        .padding(.vertical, 4)
    }

    private var categoryIcon: String {
        let category = Category.defaultCategories.first { $0.name == transaction.category }
        return category?.icon ?? "dollarsign.circle.fill"
    }

    private var categoryColor: Color {
        let category = Category.defaultCategories.first { $0.name == transaction.category }
        if let hexColor = category?.color {
            return Color(hex: hexColor) ?? .blue
        }
        return .blue
    }
}

struct FilterPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .cornerRadius(20)
        }
    }
}

// Color extension to support hex colors
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    TransactionsView()
        .modelContainer(for: [Transaction.self, CreditCard.self])
}
