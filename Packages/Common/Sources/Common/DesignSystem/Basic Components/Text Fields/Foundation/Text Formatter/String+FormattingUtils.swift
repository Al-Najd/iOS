//
//  String+FormattingUtils.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import Foundation

public extension String {
    func characterAt(_ index: Int) -> Character? {
        guard index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }

    func sliceAfter(substring: String) -> String {
        guard contains(substring) else { return self }
        guard count > substring.count else { return "" }
        guard let lastSubstringCharacter = substring.last else { return "" }
        guard let substringIndex = firstIndex(of: lastSubstringCharacter) else { return "" }
        let indexAfterSubstringIndex = index(substringIndex, offsetBy: 1)
        return String(self[indexAfterSubstringIndex..<endIndex])
    }

    func sliceBefore(substring: String) -> String {
        guard contains(substring) else { return self }
        guard count > substring.count else { return "" }
        guard let firstSubstringCharacter = substring.first else { return self }
        guard let substringStartIndex = lastIndex(of: firstSubstringCharacter) else { return self }
        return String(self[startIndex..<substringStartIndex])
    }

    // swiftlint:disable identifier_name
    func slice(from: String, to: String) -> String {
        sliceAfter(substring: from).sliceBefore(substring: to)
    }

    func removePrefix(_ prefix: String) -> String {
        guard !prefix.isEmpty else { return self }
        return sliceAfter(substring: prefix)
    }

    func removeSuffix(_ suffix: String) -> String {
        guard !suffix.isEmpty else { return self }
        return sliceBefore(substring: suffix)
    }

    func leftSlice(limit: Int) -> String {
        guard limit < count else { return self }
        let rangeBegin = startIndex
        let rangeEnd = index(startIndex, offsetBy: limit)
        return String(self[rangeBegin..<rangeEnd])
    }

    func leftSlice(end: String.Index) -> String {
        String(self[startIndex..<end])
    }

    func slice(in range: Range<String.Index>) -> String {
        String(self[range])
    }

    func slice(from: Int, length: Int) -> String? {
        guard from < count, from + length < count else { return nil }
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(fromIndex, offsetBy: length)
        return String(self[fromIndex..<toIndex])
    }

    func replacingCharacters(in range: NSRange, with replacement: String) -> String {
        guard range.location <= count else { return self }
        let maxLength = count
        var limitedRange = NSRange(location: range.location, length: range.length)
        if range.location + range.length > maxLength {
            limitedRange.length = count - range.location
        }
        guard let swiftRange = Range(limitedRange, in: self) else { return self }
        return replacingCharacters(in: swiftRange, with: replacement)
    }

    func isSameCharacter(at position: Int, character: Character) -> Bool {
        guard let characterAtPosition = characterAt(position) else { return false }
        return characterAtPosition == character
    }

    func getSameRange(asIn source: String, sourceRange: Range<String.Index>) -> Range<String.Index> {
        let startIndexDistance = source.distance(from: source.startIndex, to: sourceRange.lowerBound)
        let startIndex = index(startIndex, offsetBy: startIndexDistance, limitedBy: endIndex) ?? endIndex
        let endIndexDistance = source.distance(from: source.startIndex, to: sourceRange.upperBound)
        let endIndex = index(self.startIndex, offsetBy: endIndexDistance, limitedBy: endIndex) ?? endIndex
        return startIndex..<endIndex
    }

    func getSameIndex(asIn source: String, sourceIndex: String.Index) -> String.Index {
        let distance = source.distance(from: source.startIndex, to: sourceIndex)
        return index(startIndex, offsetBy: distance)
    }

    func getRangeWithOffsets(
        sourceRange: Range<String.Index>,
        lowerBoundOffset: Int,
        upperBoundOffset: Int) -> Range<String.Index> {
        let sourceRangeLowerBoundDistance = distance(from: startIndex, to: sourceRange.lowerBound)
        let startIndex = index(startIndex, offsetBy: sourceRangeLowerBoundDistance + lowerBoundOffset)

        let sourceRangeUpperBoundDistance = distance(from: self.startIndex, to: sourceRange.upperBound)
        let endIndex = index(self.startIndex, offsetBy: sourceRangeUpperBoundDistance + lowerBoundOffset + upperBoundOffset)

        return startIndex..<endIndex
    }

    func findIndex(of element: Character, skipFirst: Int, startFrom: String.Index) -> String.Index {
        var skipFirst = skipFirst
        var elementIndex = startFrom
        while skipFirst > 0, elementIndex < endIndex {
            let elementToCompare = self[elementIndex]
            if element == elementToCompare {
                skipFirst -= 1
            }
            elementIndex = index(after: elementIndex)
        }
        return elementIndex
    }

    func findIndexBefore(of element: Character, startFrom: String.Index) -> String.Index {
        var elementIndex = startFrom
        while elementIndex > startIndex {
            let elementIndexBefore = index(before: elementIndex)
            let elementToCompare = self[elementIndexBefore]
            if element == elementToCompare {
                return elementIndex
            }
            elementIndex = elementIndexBefore
        }
        return elementIndex
    }

    func getRemovingMatches(toMatch: String) -> String {
        guard self != toMatch else { return "" }
        var stringIndex = index(before: endIndex)
        var toMatchIndex = toMatch.index(before: toMatch.endIndex)
        while stringIndex > startIndex, toMatchIndex > toMatch.startIndex {
            let stringChar = self[stringIndex]
            let toMatchChar = toMatch[toMatchIndex]
            if stringChar != toMatchChar {
                break
            }
            stringIndex = index(before: stringIndex)
            toMatchIndex = toMatch.index(before: toMatchIndex)
        }
        return leftSlice(end: index(after: stringIndex))
    }

    var utf16Length: Int {
        utf16.count
    }
}
