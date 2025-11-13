import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct UploadView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cards: [CreditCard]

    @State private var showingFilePicker = false
    @State private var showingCardSelector = false
    @State private var selectedCard: CreditCard?
    @State private var isProcessing = false
    @State private var processingStatus = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                if isProcessing {
                    ProgressView(processingStatus)
                        .padding()
                } else {
                    Image(systemName: "doc.text.viewfinder")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                        .padding()

                    Text("Upload Credit Card Statement")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("Select a PDF statement to import transactions")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    if !cards.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Select Card")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Button(action: { showingCardSelector = true }) {
                                HStack {
                                    if let card = selectedCard {
                                        Text(card.name)
                                    } else {
                                        Text("Choose a card...")
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                            .foregroundColor(.primary)
                        }
                        .padding(.horizontal)
                    }

                    Button(action: {
                        if cards.isEmpty {
                            alertMessage = "Please add a credit card first from the Cards tab"
                            showingAlert = true
                        } else if selectedCard == nil {
                            alertMessage = "Please select a card first"
                            showingAlert = true
                        } else {
                            showingFilePicker = true
                        }
                    }) {
                        Label("Choose PDF Statement", systemImage: "doc.badge.plus")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationTitle("Upload Statement")
            .fileImporter(
                isPresented: $showingFilePicker,
                allowedContentTypes: [.pdf],
                allowsMultipleSelection: false
            ) { result in
                handleFileImport(result: result)
            }
            .sheet(isPresented: $showingCardSelector) {
                CardSelectorSheet(selectedCard: $selectedCard, cards: cards)
            }
            .alert("Notice", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func handleFileImport(result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else { return }
            processStatement(from: url)
        case .failure(let error):
            alertMessage = "Failed to import file: \(error.localizedDescription)"
            showingAlert = true
        }
    }

    private func processStatement(from url: URL) {
        guard let card = selectedCard else { return }

        isProcessing = true
        processingStatus = "Reading statement..."

        Task {
            do {
                let parser = StatementParser()
                let parsed = try await parser.parseStatement(from: url)

                await MainActor.run {
                    processingStatus = "Importing \(parsed.count) transactions..."
                }

                // Create Transaction objects
                for parsedTx in parsed {
                    let transaction = Transaction(
                        date: parsedTx.date,
                        merchant: parsedTx.merchant,
                        amount: parsedTx.amount,
                        description: parsedTx.description,
                        category: categorizeTransaction(merchant: parsedTx.merchant)
                    )
                    transaction.card = card
                    modelContext.insert(transaction)
                }

                try modelContext.save()

                // Detect recurring transactions
                await MainActor.run {
                    processingStatus = "Detecting recurring charges..."
                }

                let allTransactions = try modelContext.fetch(FetchDescriptor<Transaction>())
                let detector = RecurringDetector()
                let patterns = detector.detectRecurringTransactions(from: allTransactions)
                detector.markRecurringTransactions(patterns: patterns)
                try modelContext.save()

                await MainActor.run {
                    isProcessing = false
                    alertMessage = "Successfully imported \(parsed.count) transactions!"
                    showingAlert = true
                }

            } catch {
                await MainActor.run {
                    isProcessing = false
                    alertMessage = "Error processing statement: \(error.localizedDescription)"
                    showingAlert = true
                }
            }
        }
    }

    private func categorizeTransaction(merchant: String) -> String {
        let merchantLower = merchant.lowercased()

        // Simple keyword-based categorization
        let categories: [(keywords: [String], category: String)] = [
            (["grocery", "safeway", "whole foods", "trader joe", "kroger"], "Groceries"),
            (["restaurant", "cafe", "coffee", "starbucks", "mcdonald", "pizza"], "Dining"),
            (["uber", "lyft", "taxi", "transit", "parking"], "Transportation"),
            (["gas", "shell", "chevron", "exxon", "fuel"], "Gas"),
            (["netflix", "spotify", "hulu", "prime", "disney"], "Subscriptions"),
            (["amazon", "target", "walmart", "best buy"], "Shopping"),
            (["electric", "water", "internet", "phone", "utility"], "Bills & Utilities"),
            (["movie", "theater", "concert", "game"], "Entertainment"),
            (["flight", "hotel", "airbnb", "airline"], "Travel"),
            (["pharmacy", "cvs", "walgreens", "doctor", "hospital"], "Healthcare")
        ]

        for (keywords, category) in categories {
            if keywords.contains(where: { merchantLower.contains($0) }) {
                return category
            }
        }

        return "Other"
    }
}

struct CardSelectorSheet: View {
    @Binding var selectedCard: CreditCard?
    let cards: [CreditCard]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(cards) { card in
                Button(action: {
                    selectedCard = card
                    dismiss()
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(card.name)
                                .font(.headline)
                            Text("•••• \(card.lastFourDigits)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if selectedCard?.id == card.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Select Card")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
