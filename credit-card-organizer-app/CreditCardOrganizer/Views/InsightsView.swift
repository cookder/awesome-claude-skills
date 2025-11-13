import SwiftUI
import SwiftData
import Charts

struct InsightsView: View {
    @Query private var transactions: [Transaction]

    var totalSpent: Double {
        transactions.reduce(0) { $0 + $1.amount }
    }

    var recurringCount: Int {
        transactions.filter { $0.transactionType == .recurring || $0.transactionType == .subscription }.count
    }

    var categoryTotals: [(category: String, amount: Double)] {
        let grouped = Dictionary(grouping: transactions) { $0.category }
        return grouped.map { (category: $0.key, amount: $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.amount > $1.amount }
    }

    var monthlyTotals: [(month: String, amount: Double)] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: transactions) { transaction -> String in
            let components = calendar.dateComponents([.year, .month], from: transaction.date)
            return "\(components.year ?? 0)-\(String(format: "%02d", components.month ?? 0))"
        }

        return grouped.map { (month: $0.key, amount: $0.value.reduce(0) { $0 + $1.amount }) }
            .sorted { $0.month < $1.month }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Summary cards
                    HStack(spacing: 16) {
                        SummaryCard(
                            title: "Total Spent",
                            value: "$\(totalSpent, specifier: "%.2f")",
                            icon: "dollarsign.circle.fill",
                            color: .blue
                        )

                        SummaryCard(
                            title: "Transactions",
                            value: "\(transactions.count)",
                            icon: "list.bullet.rectangle.fill",
                            color: .green
                        )
                    }
                    .padding(.horizontal)

                    HStack(spacing: 16) {
                        SummaryCard(
                            title: "Recurring",
                            value: "\(recurringCount)",
                            icon: "repeat.circle.fill",
                            color: .orange
                        )

                        SummaryCard(
                            title: "Categories",
                            value: "\(categoryTotals.count)",
                            icon: "square.grid.2x2.fill",
                            color: .purple
                        )
                    }
                    .padding(.horizontal)

                    // Spending by Category
                    if !categoryTotals.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Spending by Category")
                                .font(.headline)
                                .padding(.horizontal)

                            VStack(spacing: 8) {
                                ForEach(categoryTotals.prefix(5), id: \.category) { item in
                                    CategoryBar(
                                        category: item.category,
                                        amount: item.amount,
                                        total: totalSpent
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 5)
                        .padding(.horizontal)
                    }

                    // Monthly Spending Trend
                    if monthlyTotals.count > 1 {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Monthly Spending")
                                .font(.headline)
                                .padding(.horizontal)

                            Chart {
                                ForEach(monthlyTotals, id: \.month) { item in
                                    BarMark(
                                        x: .value("Month", item.month),
                                        y: .value("Amount", item.amount)
                                    )
                                    .foregroundStyle(Color.blue.gradient)
                                }
                            }
                            .frame(height: 200)
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 5)
                        .padding(.horizontal)
                    }

                    Spacer()
                }
                .padding(.vertical)
            }
            .navigationTitle("Insights")
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct SummaryCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Spacer()
            }

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

struct CategoryBar: View {
    let category: String
    let amount: Double
    let total: Double

    var percentage: Double {
        total > 0 ? (amount / total) * 100 : 0
    }

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(category)
                    .font(.subheadline)
                Spacer()
                Text("$\(amount, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                        .cornerRadius(4)

                    Rectangle()
                        .fill(categoryColor)
                        .frame(width: geometry.size.width * (percentage / 100), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }

    private var categoryColor: Color {
        let defaultCategory = Category.defaultCategories.first { $0.name == category }
        if let hexColor = defaultCategory?.color {
            return Color(hex: hexColor) ?? .blue
        }
        return .blue
    }
}

#Preview {
    InsightsView()
        .modelContainer(for: [Transaction.self, CreditCard.self])
}
