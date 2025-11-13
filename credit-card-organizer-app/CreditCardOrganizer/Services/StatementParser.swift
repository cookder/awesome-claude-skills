import Foundation
import PDFKit
import Vision

class StatementParser {

    /// Parse a PDF statement and extract transactions
    func parseStatement(from url: URL) async throws -> [ParsedTransaction] {
        guard let pdfDocument = PDFDocument(url: url) else {
            throw ParserError.invalidPDF
        }

        var allText = ""
        for pageIndex in 0..<pdfDocument.pageCount {
            guard let page = pdfDocument.page(at: pageIndex),
                  let pageText = page.string else {
                continue
            }
            allText += pageText + "\n"
        }

        return try parseTransactionsFromText(allText)
    }

    /// Parse transactions from extracted text
    private func parseTransactionsFromText(_ text: String) throws -> [ParsedTransaction] {
        var transactions: [ParsedTransaction] = []
        let lines = text.components(separatedBy: .newlines)

        // Check if this is CSV format
        if let firstLine = lines.first, firstLine.contains("Date") && firstLine.contains("Amount") && firstLine.contains("Merchant") {
            // CSV format detected
            transactions = parseCSVFormat(lines: lines)
        } else {
            // Regular text format
            for line in lines {
                if let transaction = parseLine(line) {
                    transactions.append(transaction)
                }
            }
        }

        return transactions
    }

    /// Parse CSV format transactions
    private func parseCSVFormat(lines: [String]) -> [ParsedTransaction] {
        var transactions: [ParsedTransaction] = []

        guard lines.count > 1 else { return transactions }

        // Skip header line
        for line in lines.dropFirst() {
            if let transaction = parseCSVLine(line) {
                transactions.append(transaction)
            }
        }

        return transactions
    }

    /// Parse a single CSV line
    private func parseCSVLine(_ line: String) -> ParsedTransaction? {
        let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        // Split by comma, handling quoted fields
        let fields = parseCSVFields(line: trimmed)

        // Expected format: Date,Time,Cardholder,Amount,Points,Balance,Status,Type,Merchant,Description
        guard fields.count >= 9 else { return nil }

        let dateString = fields[0]
        let amountString = fields[3]
        let merchant = fields[8]

        // Parse date (YYYY-MM-DD format)
        guard let date = parseDate(from: dateString) else { return nil }

        // Parse amount
        let cleanAmount = amountString.replacingOccurrences(of: ",", with: "")
        guard let amount = Double(cleanAmount) else { return nil }

        // Clean merchant name (remove quotes if present)
        let cleanMerchant = merchant.trimmingCharacters(in: CharacterSet(charactersIn: "\""))

        return ParsedTransaction(
            date: date,
            merchant: cleanMerchant,
            amount: amount,
            description: trimmed
        )
    }

    /// Parse CSV fields handling quoted values
    private func parseCSVFields(line: String) -> [String] {
        var fields: [String] = []
        var currentField = ""
        var insideQuotes = false

        for char in line {
            if char == "\"" {
                insideQuotes.toggle()
            } else if char == "," && !insideQuotes {
                fields.append(currentField)
                currentField = ""
            } else {
                currentField.append(char)
            }
        }

        // Add the last field
        if !currentField.isEmpty {
            fields.append(currentField)
        }

        return fields
    }

    /// Attempt to parse a single line as a transaction
    /// Common formats:
    /// - MM/DD/YYYY MERCHANT NAME $XXX.XX
    /// - MM/DD MERCHANT NAME XXX.XX
    /// - YYYY-MM-DD MERCHANT XXX.XX
    private func parseLine(_ line: String) -> ParsedTransaction? {
        let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        // Simple regex patterns for common statement formats
        let patterns = [
            // Pattern 1: MM/DD/YYYY MERCHANT $XXX.XX or XXX.XX
            #"(\d{1,2}/\d{1,2}/\d{2,4})\s+(.+?)\s+\$?([\d,]+\.\d{2})"#,
            // Pattern 2: YYYY-MM-DD MERCHANT XXX.XX
            #"(\d{4}-\d{2}-\d{2})\s+(.+?)\s+\$?([\d,]+\.\d{2})"#,
            // Pattern 3: MM/DD MERCHANT XXX.XX
            #"(\d{1,2}/\d{1,2})\s+(.+?)\s+\$?([\d,]+\.\d{2})"#
        ]

        for pattern in patterns {
            if let transaction = tryParseWithPattern(line: trimmed, pattern: pattern) {
                return transaction
            }
        }

        return nil
    }

    private func tryParseWithPattern(line: String, pattern: String) -> ParsedTransaction? {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return nil
        }

        let range = NSRange(line.startIndex..., in: line)
        guard let match = regex.firstMatch(in: line, range: range) else {
            return nil
        }

        guard match.numberOfRanges >= 4 else { return nil }

        // Extract date
        guard let dateRange = Range(match.range(at: 1), in: line) else { return nil }
        let dateString = String(line[dateRange])

        // Extract merchant
        guard let merchantRange = Range(match.range(at: 2), in: line) else { return nil }
        let merchant = String(line[merchantRange]).trimmingCharacters(in: .whitespaces)

        // Extract amount
        guard let amountRange = Range(match.range(at: 3), in: line) else { return nil }
        let amountString = String(line[amountRange]).replacingOccurrences(of: ",", with: "")
        guard let amount = Double(amountString) else { return nil }

        // Parse date
        let date = parseDate(from: dateString) ?? Date()

        return ParsedTransaction(
            date: date,
            merchant: merchant,
            amount: amount,
            description: line
        )
    }

    private func parseDate(from string: String) -> Date? {
        let formatters = [
            "MM/dd/yyyy",
            "M/d/yyyy",
            "MM/dd/yy",
            "M/d/yy",
            "yyyy-MM-dd",
            "MM/dd",
            "M/d"
        ]

        for format in formatters {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            if let date = formatter.date(from: string) {
                // If year is missing, use current year
                if format.contains("MM/dd") && !format.contains("yyyy") {
                    let calendar = Calendar.current
                    var components = calendar.dateComponents([.month, .day], from: date)
                    components.year = calendar.component(.year, from: Date())
                    return calendar.date(from: components)
                }
                return date
            }
        }

        return nil
    }
}

// MARK: - Supporting Types

struct ParsedTransaction {
    let date: Date
    let merchant: String
    let amount: Double
    let description: String
}

enum ParserError: Error {
    case invalidPDF
    case noTextFound
    case parsingFailed

    var localizedDescription: String {
        switch self {
        case .invalidPDF:
            return "Unable to read PDF file"
        case .noTextFound:
            return "No text found in document"
        case .parsingFailed:
            return "Failed to parse transactions"
        }
    }
}
