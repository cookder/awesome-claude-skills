import SwiftUI
import SwiftData

struct CardsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cards: [CreditCard]

    @State private var showingAddCard = false

    var body: some View {
        NavigationStack {
            if cards.isEmpty {
                ContentUnavailableView(
                    "No Cards",
                    systemImage: "creditcard",
                    description: Text("Add your first credit card to get started")
                )
            } else {
                List {
                    ForEach(cards) { card in
                        CardRow(card: card)
                    }
                    .onDelete(perform: deleteCards)
                }
            }
        }
        .navigationTitle("Cards")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddCard = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddCard) {
            AddCardView()
        }
    }

    private func deleteCards(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(cards[index])
        }
    }
}

struct CardRow: View {
    let card: CreditCard

    var transactionCount: Int {
        card.transactions?.count ?? 0
    }

    var totalSpent: Double {
        card.transactions?.reduce(0) { $0 + $1.amount } ?? 0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.name)
                        .font(.headline)

                    Text("\(card.cardType) •••• \(card.lastFourDigits)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Circle()
                    .fill(Color(hex: card.color) ?? .blue)
                    .frame(width: 12, height: 12)
            }

            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Transactions")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(transactionCount)")
                        .font(.headline)
                }

                Divider()
                    .frame(height: 30)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Spent")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("$\(totalSpent, specifier: "%.2f")")
                        .font(.headline)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct AddCardView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var lastFourDigits = ""
    @State private var selectedType = "Visa"
    @State private var selectedColor = "#007AFF"

    let cardTypes = ["Visa", "Mastercard", "American Express", "Discover", "Other"]
    let colorOptions = [
        "#007AFF", // Blue
        "#FF3B30", // Red
        "#34C759", // Green
        "#FF9500", // Orange
        "#5856D6", // Purple
        "#00C7BE", // Teal
        "#FFCC00", // Yellow
        "#8E8E93"  // Gray
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section("Card Details") {
                    TextField("Card Name", text: $name)
                        .textContentType(.name)

                    TextField("Last 4 Digits", text: $lastFourDigits)
                        .keyboardType(.numberPad)
                        .onChange(of: lastFourDigits) { _, newValue in
                            if newValue.count > 4 {
                                lastFourDigits = String(newValue.prefix(4))
                            }
                        }

                    Picker("Card Type", selection: $selectedType) {
                        ForEach(cardTypes, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
                }

                Section("Color") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 12) {
                        ForEach(colorOptions, id: \.self) { color in
                            Button(action: {
                                selectedColor = color
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color(hex: color) ?? .blue)
                                        .frame(width: 44, height: 44)

                                    if selectedColor == color {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Add Card")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveCard()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }

    private var isValid: Bool {
        !name.isEmpty && lastFourDigits.count == 4
    }

    private func saveCard() {
        let newCard = CreditCard(
            name: name,
            lastFourDigits: lastFourDigits,
            cardType: selectedType,
            color: selectedColor
        )

        modelContext.insert(newCard)
        dismiss()
    }
}

#Preview {
    CardsView()
        .modelContainer(for: [CreditCard.self, Transaction.self])
}
