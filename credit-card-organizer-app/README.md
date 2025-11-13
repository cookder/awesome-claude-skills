# Credit Card Statement Organizer

A simple, privacy-first iOS app for organizing and categorizing your credit card transactions locally on your iPhone.

## Features

### Core Functionality
- **Upload PDF Statements** - Import credit card statements in PDF format
- **Automatic Parsing** - Extract transaction data from statements
- **Local Storage** - All data stored securely on your device with SwiftData
- **Smart Categorization** - Automatically categorize transactions by type

### Organization
1. **By Card** - Track transactions across multiple credit cards
2. **By Type** - Categorize as Single, Recurring, or Subscription charges
3. **By Category** - Organize by merchant category (Groceries, Dining, Travel, etc.)

### Additional Features
- **Recurring Detection** - Automatically identify subscription and recurring charges
- **Search & Filter** - Find transactions quickly by merchant, category, or type
- **Insights Dashboard** - View spending patterns and trends
- **Transaction Editing** - Manually adjust categories and types as needed

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## Installation

### Option 1: Build with Xcode

1. **Clone or download this repository**
   ```bash
   cd credit-card-organizer-app
   ```

2. **Create an Xcode project**
   - Open Xcode
   - Select "Create a new Xcode project"
   - Choose "iOS" → "App"
   - Product Name: `CreditCardOrganizer`
   - Organization Identifier: `com.yourname` (use your own)
   - Interface: SwiftUI
   - Language: Swift
   - Storage: SwiftData
   - Click "Next" and save

3. **Copy the source files**
   - Replace the default `ContentView.swift` and app file with the files from this repository
   - Add all files from the `CreditCardOrganizer` directory to your Xcode project:
     - Models/
     - Views/
     - Services/

4. **Configure the project**
   - In Xcode, select your project in the navigator
   - Under "Signing & Capabilities", select your team
   - Ensure the deployment target is iOS 17.0+

5. **Build and run**
   - Connect your iPhone or use the simulator
   - Click the Play button (⌘R) to build and run

### Option 2: Quick Setup Script

If you have the files locally, you can create an Xcode project programmatically:

```bash
# This will be added in the future - for now use Xcode directly
```

## Usage

### 1. Add Your Credit Cards

1. Tap the **Cards** tab
2. Tap the **+** button
3. Enter card details:
   - Card name (e.g., "Chase Sapphire")
   - Last 4 digits
   - Card type (Visa, Mastercard, etc.)
   - Choose a color for easy identification

### 2. Upload a Statement

1. Tap the **Upload** tab
2. Select which card the statement is for
3. Tap "Choose PDF Statement"
4. Select your credit card statement PDF
5. Wait for processing - the app will:
   - Extract all transactions
   - Categorize them automatically
   - Detect recurring charges

### 3. Review Transactions

1. Tap the **Transactions** tab
2. Browse all your transactions
3. Filter by:
   - Transaction type (Single, Recurring, Subscription)
   - Category (Groceries, Dining, Travel, etc.)
4. Search by merchant name
5. Tap any transaction to edit its category or type

### 4. View Insights

1. Tap the **Insights** tab
2. See:
   - Total spending
   - Transaction counts
   - Recurring charge summary
   - Spending by category
   - Monthly trends

## How It Works

### Statement Parsing

The app uses pattern matching to extract transaction data from PDF statements. It looks for common formats:

```
MM/DD/YYYY MERCHANT NAME $XXX.XX
MM/DD MERCHANT NAME XXX.XX
YYYY-MM-DD MERCHANT XXX.XX
```

If your statement format isn't recognized, you can:
- Manually add transactions
- Contact support with a sample format (no personal data)

### Auto-Categorization

Transactions are automatically categorized based on merchant name keywords:

- **Groceries**: Safeway, Whole Foods, Trader Joe's, etc.
- **Dining**: Restaurants, cafes, Starbucks, etc.
- **Transportation**: Uber, Lyft, transit, parking
- **Subscriptions**: Netflix, Spotify, Hulu, etc.
- **And more...**

You can always manually adjust categories in the transaction detail view.

### Recurring Detection

The app analyzes transaction history to find patterns:

1. Groups transactions by merchant and amount
2. Calculates time intervals between charges
3. Identifies consistent patterns (weekly, monthly, etc.)
4. Marks likely subscriptions and recurring charges

## Data Privacy

**Your data never leaves your device.**

- All data stored locally using SwiftData
- No internet connection required
- No analytics or tracking
- No cloud backups (unless you use iCloud backup)

## Troubleshooting

### Statement Not Parsing Correctly

If your PDF statement isn't being parsed:

1. Check that it's a text-based PDF (not a scanned image)
2. Try manually adding a few transactions to see the format
3. The parser works best with standard bank statement formats

### Missing Transactions

- Ensure the PDF contains transaction details
- Some statements have transactions on multiple pages
- Check if transactions are in a supported format

### App Won't Build

- Ensure you're using Xcode 15+ and iOS 17+
- Check that all files are added to the target
- Verify SwiftData is selected in project settings

## Roadmap

Future features (you mentioned you'll add these later):

- ✅ Basic storage and categorization (DONE)
- 🔜 AI-powered insights and analysis
- 🔜 Budget tracking
- 🔜 Export to CSV/Excel
- 🔜 Receipt photo scanning
- 🔜 Custom categories
- 🔜 Multi-currency support

## Technical Details

### Architecture

- **SwiftUI** - Modern declarative UI
- **SwiftData** - Local persistence layer
- **PDFKit** - PDF statement reading
- **MVVM Pattern** - Clean separation of concerns

### Project Structure

```
CreditCardOrganizer/
├── Models/
│   ├── CreditCard.swift       # Card data model
│   ├── Transaction.swift      # Transaction data model
│   └── Category.swift         # Category definitions
├── Views/
│   ├── ContentView.swift      # Main tab navigation
│   ├── CardsView.swift        # Card management
│   ├── UploadView.swift       # Statement upload
│   ├── TransactionsView.swift # Transaction list
│   ├── TransactionDetailView.swift
│   └── InsightsView.swift     # Analytics dashboard
└── Services/
    ├── StatementParser.swift  # PDF parsing logic
    └── RecurringDetector.swift # Pattern detection
```

## Contributing

This is a personal project, but suggestions are welcome! Feel free to:

- Report bugs
- Suggest features
- Share statement formats that don't parse correctly

## License

MIT License - Use freely, no attribution required.

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review the code comments
3. Open an issue on GitHub

---

**Built with Claude Code** 🤖

Simple, private, and effective credit card statement organization.
