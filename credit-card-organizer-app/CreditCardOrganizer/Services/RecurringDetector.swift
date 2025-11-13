import Foundation
import SwiftData

class RecurringDetector {

    /// Detect recurring transactions based on merchant name and amount patterns
    func detectRecurringTransactions(from transactions: [Transaction]) -> [RecurringPattern] {
        var patterns: [RecurringPattern] = []

        // Group transactions by merchant and amount
        let grouped = Dictionary(grouping: transactions) { transaction in
            RecurringKey(
                merchant: transaction.merchant.lowercased(),
                amount: transaction.amount
            )
        }

        // Find patterns with 2+ occurrences
        for (key, group) in grouped {
            guard group.count >= 2 else { continue }

            // Sort by date
            let sorted = group.sorted { $0.date < $1.date }

            // Calculate intervals between transactions
            var intervals: [TimeInterval] = []
            for i in 1..<sorted.count {
                let interval = sorted[i].date.timeIntervalSince(sorted[i-1].date)
                intervals.append(interval)
            }

            // Check if intervals are consistent (within 3 days tolerance)
            let avgInterval = intervals.reduce(0, +) / Double(intervals.count)
            let isConsistent = intervals.allSatisfy { interval in
                abs(interval - avgInterval) < (3 * 24 * 60 * 60) // 3 days
            }

            if isConsistent {
                let frequency = determineFrequency(from: avgInterval)
                patterns.append(RecurringPattern(
                    merchant: key.merchant,
                    amount: key.amount,
                    frequency: frequency,
                    occurrences: group.count,
                    transactions: sorted
                ))
            }
        }

        return patterns
    }

    /// Mark transactions as recurring based on detected patterns
    func markRecurringTransactions(patterns: [RecurringPattern]) {
        for pattern in patterns {
            for transaction in pattern.transactions {
                transaction.transactionType = pattern.frequency == .monthly ? .subscription : .recurring
                transaction.isRecurringCandidate = true
            }
        }
    }

    private func determineFrequency(from interval: TimeInterval) -> RecurringFrequency {
        let days = interval / (24 * 60 * 60)

        switch days {
        case 6...8:
            return .weekly
        case 13...16:
            return .biweekly
        case 28...32:
            return .monthly
        case 88...95:
            return .quarterly
        case 350...380:
            return .yearly
        default:
            return .custom(days: Int(days))
        }
    }
}

// MARK: - Supporting Types

struct RecurringKey: Hashable {
    let merchant: String
    let amount: Double

    func hash(into hasher: inout Hasher) {
        hasher.combine(merchant)
        // Round amount to 2 decimals for comparison
        hasher.combine(String(format: "%.2f", amount))
    }

    static func == (lhs: RecurringKey, rhs: RecurringKey) -> Bool {
        return lhs.merchant == rhs.merchant &&
               abs(lhs.amount - rhs.amount) < 0.01
    }
}

struct RecurringPattern {
    let merchant: String
    let amount: Double
    let frequency: RecurringFrequency
    let occurrences: Int
    let transactions: [Transaction]
}

enum RecurringFrequency: Equatable {
    case weekly
    case biweekly
    case monthly
    case quarterly
    case yearly
    case custom(days: Int)

    var description: String {
        switch self {
        case .weekly: return "Weekly"
        case .biweekly: return "Bi-weekly"
        case .monthly: return "Monthly"
        case .quarterly: return "Quarterly"
        case .yearly: return "Yearly"
        case .custom(let days): return "Every \(days) days"
        }
    }
}
