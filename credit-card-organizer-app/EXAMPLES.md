# Usage Examples

## Example Workflows

### Scenario 1: Monthly Statement Upload

**Goal**: Import your Chase credit card statement from March 2024

1. **Prepare**:
   - Download your statement PDF from your bank's website
   - Save it to your iPhone (Files app or email attachment)

2. **Add Card** (first time only):
   - Open app → Cards tab → Tap +
   - Name: "Chase Freedom"
   - Last 4: "1234"
   - Type: "Visa"
   - Color: Blue
   - Tap Save

3. **Upload Statement**:
   - Upload tab → Select "Chase Freedom"
   - Tap "Choose PDF Statement"
   - Select your March statement PDF
   - Wait ~5-10 seconds for processing

4. **Review**:
   - Go to Transactions tab
   - See all March transactions imported
   - Filter by category to review

**Result**: All 47 transactions imported, 5 recurring charges detected automatically

---

### Scenario 2: Managing Multiple Cards

**Goal**: Track spending across 3 different credit cards

1. **Add All Your Cards**:
   ```
   Card 1: Chase Sapphire (Visa, Blue)
   Card 2: AmEx Platinum (American Express, Gold)
   Card 3: Citi Double Cash (Mastercard, Green)
   ```

2. **Upload Each Statement**:
   - Upload March statement for Chase → Select Chase
   - Upload March statement for AmEx → Select AmEx
   - Upload March statement for Citi → Select Citi

3. **View Combined Insights**:
   - Insights tab shows spending across ALL cards
   - Transactions tab shows everything with card badges
   - Filter by specific card using search: "1234"

**Result**: Complete view of all spending across all cards in one place

---

### Scenario 3: Finding Recurring Subscriptions

**Goal**: Identify all your subscription charges

1. **Upload 2-3 Months of Statements**:
   - Upload January statement
   - Upload February statement
   - Upload March statement

2. **Let the App Analyze**:
   - After each upload, the app detects patterns
   - Recurring charges are automatically marked

3. **Review Subscriptions**:
   - Transactions tab → Filter: "Subscription"
   - See all recurring charges:
     - Netflix: $15.99/month
     - Spotify: $9.99/month
     - Adobe: $52.99/month
     - etc.

4. **Manual Adjustments**:
   - Tap any transaction
   - Change type from "Single" to "Subscription" if needed

**Result**: Complete list of all recurring charges and subscriptions

---

### Scenario 4: Budget Review by Category

**Goal**: See how much you spent on dining last month

1. **After Uploading March Statement**:
   - Transactions tab → Filter by "Dining" category
   - See all restaurant and food charges

2. **Review Details**:
   - 23 dining transactions
   - Total: $487.50
   - Most frequent: Starbucks (8 times)

3. **Recategorize if Needed**:
   - Find grocery store in "Dining"?
   - Tap it → Change to "Groceries"
   - Transaction updates immediately

4. **Check Insights**:
   - Insights tab shows updated category totals
   - Compare to previous months

**Result**: Accurate spending breakdown by category

---

## Sample Transaction Formats

The app can parse these common statement formats:

### Format 1: Standard US Format
```
03/15/2024    STARBUCKS #12345        $5.75
03/14/2024    AMAZON.COM              $127.89
03/13/2024    SHELL OIL               $45.00
```

### Format 2: ISO Date Format
```
2024-03-15    WHOLE FOODS MKT         67.45
2024-03-14    UBER TRIP               18.32
2024-03-13    NETFLIX.COM             15.99
```

### Format 3: Short Date Format
```
03/15    TARGET STORE #1234          142.67
03/14    VERIZON WIRELESS             85.00
03/13    SPOTIFY USA                   9.99
```

### Format 4: With Extra Details
```
03/15/2024    STARBUCKS #12345 SEATTLE WA        $5.75 DEBIT
03/14/2024    AMAZON.COM MARKETPLACE             $127.89
03/13/2024    SHELL OIL #89012 PORTLAND OR       $45.00 FUEL
```

---

## Category Examples

The app auto-categorizes based on merchant names:

| Merchant | Auto Category |
|----------|---------------|
| Safeway, Whole Foods, Trader Joe's | Groceries |
| Starbucks, McDonald's, Pizza Hut | Dining |
| Uber, Lyft, Metro Transit | Transportation |
| Shell, Chevron, Gas Station | Gas |
| Netflix, Spotify, Hulu | Subscriptions |
| Amazon, Target, Best Buy | Shopping |
| Electric Co, Water Utility | Bills & Utilities |
| AMC Theaters, Concert | Entertainment |
| Delta Airlines, Marriott | Travel |
| CVS Pharmacy, Doctor | Healthcare |
| Anything else | Other |

You can always manually change categories!

---

## Tips & Tricks

### Tip 1: Monthly Routine
Set up a monthly routine:
1. 1st of month: Download last month's statements
2. Upload to app
3. Review categories and fix any errors
4. Check Insights for spending patterns

### Tip 2: Subscription Audit
Upload 3 months of statements to see patterns, then:
1. Filter by "Subscription"
2. Review all recurring charges
3. Cancel any unused subscriptions
4. Track monthly subscription costs

### Tip 3: Tax Preparation
For business expenses:
1. Throughout the year: Upload statements monthly
2. Use search to find business-related merchants
3. Categories like "Travel" and "Dining" are tax-relevant
4. Review Insights for year-end totals

### Tip 4: Multiple Statement Periods
Upload several months at once:
- Historical data helps with recurring detection
- Better insights and trends
- Complete annual spending picture

### Tip 5: Manual Entry
Can't upload a statement? Manually add:
1. Transactions tab → Edit
2. Add transaction details
3. Assign to correct card
4. Set category and type

---

## Common Questions

**Q: Will it work with my bank?**
A: If your bank provides PDF statements with text (not scanned images), it should work! Try uploading one and see.

**Q: What if parsing fails?**
A: You can manually add transactions or request support for your statement format.

**Q: Can I edit transactions?**
A: Yes! Tap any transaction to edit category, type, or details.

**Q: How does recurring detection work?**
A: Upload 2+ months of statements. The app finds charges with the same merchant and amount at regular intervals.

**Q: Is my data private?**
A: Completely! Everything stays on your iPhone. No internet required.

**Q: Can I export data?**
A: Not yet - this is planned for a future update!

---

## Real-World Example

**User Story**: Sarah uploads 6 months of statements

1. **Uploads**:
   - Jan-Jun 2024 Chase Sapphire statements
   - Jan-Jun 2024 AmEx statements

2. **Discoveries**:
   - 14 recurring subscriptions totaling $347/month
   - 3 she forgot about and cancels
   - Saves $47/month

3. **Insights**:
   - Dining spending up 30% vs. last quarter
   - Travel category shows $2,400 for vacation
   - Groceries averaging $450/month

4. **Actions**:
   - Sets mental budget for dining
   - Reviews subscription list quarterly
   - Uses app monthly to track progress

**Result**: Better awareness of spending, saves money, stays organized

---

Ready to try it yourself? Check out [SETUP.md](SETUP.md) to get started!
