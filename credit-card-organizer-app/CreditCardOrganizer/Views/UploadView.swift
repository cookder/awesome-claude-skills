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

                    // Sample data button for testing
                    Button(action: {
                        if cards.isEmpty {
                            alertMessage = "Please add a credit card first from the Cards tab"
                            showingAlert = true
                        } else if selectedCard == nil {
                            alertMessage = "Please select a card first"
                            showingAlert = true
                        } else {
                            loadSampleData()
                        }
                    }) {
                        Label("Load Sample Data (Testing)", systemImage: "wand.and.stars")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
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
        print("📄 File import called")
        switch result {
        case .success(let urls):
            print("📄 Success - got \(urls.count) URLs")
            guard let url = urls.first else {
                print("📄 No URL found")
                alertMessage = "No file selected"
                showingAlert = true
                return
            }
            print("📄 Processing URL: \(url)")
            processStatement(from: url)
        case .failure(let error):
            print("📄 Error: \(error.localizedDescription)")
            alertMessage = "Failed to import file: \(error.localizedDescription)"
            showingAlert = true
        }
    }

    private func processStatement(from url: URL) {
        print("🔄 processStatement called")
        guard let card = selectedCard else {
            print("❌ No card selected")
            return
        }

        print("✅ Card selected: \(card.name)")
        isProcessing = true
        processingStatus = "Reading statement..."

        Task {
            do {
                print("🔐 Requesting security access...")
                // Start accessing security-scoped resource
                guard url.startAccessingSecurityScopedResource() else {
                    print("❌ Security access denied")
                    await MainActor.run {
                        isProcessing = false
                        alertMessage = "Unable to access the file. Please try again."
                        showingAlert = true
                    }
                    return
                }
                print("✅ Security access granted")
                defer { url.stopAccessingSecurityScopedResource() }

                print("📖 Parsing statement...")
                let parser = StatementParser()
                let parsed = try await parser.parseStatement(from: url)
                print("✅ Parsed \(parsed.count) transactions")

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

    private func loadSampleData() {
        guard let card = selectedCard else { return }

        isProcessing = true
        processingStatus = "Creating sample transactions..."

        Task {
            await MainActor.run {
                // Sample transactions based on the CSV format you provided
                let sampleData = [
                    ("2025-11-12", "Elevenlabs.Io", 5.33),
                    ("2025-11-11", "Silver Diner", 47.15),
                    ("2025-11-11", "Apple", 55.17),
                    ("2025-11-11", "Oura Ring Inc", 6.39),
                    ("2025-11-10", "Cursor, AI Powered IDE", 21.32),
                    ("2025-11-10", "Frontier Airlines", 216.96),
                    ("2025-11-09", "Quick Snacks", 7.00),
                    ("2025-11-08", "Starbucks", 12.45),
                    ("2025-11-08", "Netflix", 15.99),
                    ("2025-11-07", "Uber", 23.50),
                    ("2025-11-06", "Whole Foods", 87.32),
                    ("2025-11-05", "Spotify", 9.99),
                    ("2025-11-04", "Shell Gas Station", 45.00),
                    ("2025-11-03", "Amazon", 127.89),
                    ("2025-11-02", "Target", 64.23)
                ]

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"

                for (dateString, merchant, amount) in sampleData {
                    let date = dateFormatter.date(from: dateString) ?? Date()
                    let transaction = Transaction(
                        date: date,
                        merchant: merchant,
                        amount: amount,
                        description: "\(dateString),\(merchant),\(amount)",
                        category: categorizeTransaction(merchant: merchant)
                    )
                    transaction.card = card
                    modelContext.insert(transaction)
                }

                do {
                    try modelContext.save()

                    // Detect recurring transactions
                    processingStatus = "Detecting recurring charges..."
                    let allTransactions = try modelContext.fetch(FetchDescriptor<Transaction>())
                    let detector = RecurringDetector()
                    let patterns = detector.detectRecurringTransactions(from: allTransactions)
                    detector.markRecurringTransactions(patterns: patterns)
                    try modelContext.save()

                    isProcessing = false
                    alertMessage = "Successfully loaded \(sampleData.count) sample transactions!"
                    showingAlert = true
                } catch {
                    isProcessing = false
                    alertMessage = "Error loading sample data: \(error.localizedDescription)"
                    showingAlert = true
                }
            }
        }
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
