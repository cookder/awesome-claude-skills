# Quick Setup Guide

## Transfer to Your Mac

Since this was built in a Linux environment, you'll need to transfer the files to your Mac to build with Xcode.

### Method 1: Direct Download

1. Download this entire folder to your Mac
2. Continue with "Create Xcode Project" below

### Method 2: Git (Recommended)

```bash
# If this is in a git repository, clone it on your Mac
git clone [repository-url]
cd credit-card-organizer-app
```

## Create Xcode Project

Follow these steps on your Mac:

### Step 1: Create New Xcode Project

1. Open Xcode
2. File → New → Project
3. Select **iOS** tab → **App** template → **Next**
4. Configure:
   - **Product Name**: `CreditCardOrganizer`
   - **Team**: Select your Apple ID
   - **Organization Identifier**: `com.yourname` (use your own)
   - **Interface**: SwiftUI
   - **Language**: Swift
   - **Storage**: SwiftData
   - **Include Tests**: Optional (unchecked is fine)
5. Click **Next** and choose where to save

### Step 2: Add Source Files

1. In Finder, navigate to the downloaded `CreditCardOrganizer` folder
2. In Xcode, right-click on the `CreditCardOrganizer` folder in the Project Navigator
3. Select **Add Files to "CreditCardOrganizer"...**
4. Navigate to and select these folders:
   - `Models/`
   - `Views/`
   - `Services/`
5. Make sure "Copy items if needed" is **checked**
6. Click **Add**

### Step 3: Replace Default Files

1. Delete the default `ContentView.swift` created by Xcode
2. Delete the default app file (usually named `CreditCardOrganizerApp.swift`)
3. The files you added in Step 2 will replace these

### Step 4: Configure Build Settings

1. Select your project in the Project Navigator (top item)
2. Select the **CreditCardOrganizer** target
3. Go to **Signing & Capabilities** tab
4. Under **Signing**:
   - Check "Automatically manage signing"
   - Select your Team (Apple ID)
5. Go to **General** tab
6. Ensure:
   - **Minimum Deployments**: iOS 17.0
   - **Supported Destinations**: iPhone

### Step 5: Build and Run

1. Select your iPhone from the device menu (or "Any iOS Device" for simulator)
2. Press **⌘R** or click the ▶️ Play button
3. If building for a physical device:
   - First time: Xcode may ask to register your device
   - On your iPhone: Settings → General → VPN & Device Management → Trust the developer certificate

## Troubleshooting Setup

### "No such module SwiftData"

- Ensure your deployment target is iOS 17.0 or later
- Clean build folder: Product → Clean Build Folder (⇧⌘K)

### "Cannot find type in scope"

- Check that all Swift files are added to the target
- In Project Navigator, select each file → File Inspector → ensure "CreditCardOrganizer" is checked under Target Membership

### Build Errors

1. Clean the build folder: Product → Clean Build Folder
2. Delete derived data: Xcode → Preferences → Locations → click arrow next to Derived Data folder → delete CreditCardOrganizer folder
3. Restart Xcode

### Code Signing Errors

- Ensure you're logged into Xcode with your Apple ID
- Free Apple ID works fine for personal development
- If using a physical device, ensure it's trusted in Settings

## File Structure Verification

After setup, your Xcode project should look like this:

```
CreditCardOrganizer/
├── CreditCardOrganizerApp.swift
├── Models/
│   ├── CreditCard.swift
│   ├── Transaction.swift
│   └── Category.swift
├── Views/
│   ├── ContentView.swift
│   ├── CardsView.swift
│   ├── UploadView.swift
│   ├── TransactionsView.swift
│   ├── TransactionDetailView.swift
│   └── InsightsView.swift
├── Services/
│   ├── StatementParser.swift
│   └── RecurringDetector.swift
└── Assets.xcassets/
```

## First Run

Once the app is running:

1. **Add a Card First**
   - Go to the Cards tab
   - Tap the + button
   - Add your first credit card

2. **Upload a Statement**
   - Go to Upload tab
   - Select the card you just added
   - Choose a PDF statement from your Files app
   - Wait for it to process

3. **View Transactions**
   - Go to Transactions tab
   - See all imported transactions
   - Tap any transaction to edit category or type

4. **Check Insights**
   - Go to Insights tab
   - View your spending patterns

## Next Steps

- Read the main [README.md](README.md) for full usage instructions
- Try uploading a test statement
- Customize categories as needed
- Add more cards

## Need Help?

- Check the main README.md troubleshooting section
- Review the code comments in the Swift files
- All data is local - safe to experiment!

---

Happy organizing! 📊💳
