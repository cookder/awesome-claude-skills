import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cards: [CreditCard]
    @Query private var transactions: [Transaction]

    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TransactionsView()
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet.rectangle")
                }
                .tag(0)

            CardsView()
                .tabItem {
                    Label("Cards", systemImage: "creditcard")
                }
                .tag(1)

            UploadView()
                .tabItem {
                    Label("Upload", systemImage: "arrow.up.doc")
                }
                .tag(2)

            InsightsView()
                .tabItem {
                    Label("Insights", systemImage: "chart.bar")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [CreditCard.self, Transaction.self])
}
