import SwiftUI
import SwiftData

@main
struct CreditCardOrganizerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [CreditCard.self, Transaction.self])
    }
}
