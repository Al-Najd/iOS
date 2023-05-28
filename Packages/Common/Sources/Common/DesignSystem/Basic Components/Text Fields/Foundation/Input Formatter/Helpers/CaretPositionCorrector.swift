//
//  CaretPositionCorrector.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import Foundation

public class CaretPositionCorrector {
    public let textPattern: String
    public let patternSymbol: Character

    // MARK: - Life Cycle
    public init(textPattern: String, patternSymbol: Character) {
        self.textPattern = textPattern
        self.patternSymbol = patternSymbol
    }

    public func calculateCaretPositionOffset(
        newText: String,
        originalRange range: Range<String.Index>,
        replacementText: String)
        -> Int {
        var offset = 0
        if replacementText.isEmpty {
            offset = offsetForRemove(newText: newText, lowerBound: range.lowerBound)
        } else {
            offset = offsetForInsert(newText: newText, lowerBound: range.lowerBound, replacementLength: replacementText.count)
        }
        return offset
    }

    private func offsetForRemove(newText: String, lowerBound: String.Index) -> Int {
        let textPatternLowerBound = textPattern.getSameIndex(asIn: newText, sourceIndex: lowerBound)
        let textPatternIndex = textPattern.findIndexBefore(of: patternSymbol, startFrom: textPatternLowerBound)
        let index = newText.getSameIndex(asIn: textPattern, sourceIndex: textPatternIndex)
        let leftSlice = newText.leftSlice(end: index)
        return leftSlice.utf16.count
    }

    private func offsetForInsert(newText: String, lowerBound: String.Index, replacementLength: Int) -> Int {
        let textPatternLowerBound = textPattern.getSameIndex(asIn: newText, sourceIndex: lowerBound)
        let textPatternIndex = textPattern.findIndex(
            of: patternSymbol,
            skipFirst: replacementLength,
            startFrom: textPatternLowerBound)
        let index = newText.getSameIndex(asIn: textPattern, sourceIndex: textPatternIndex)
        let leftSlice = newText.leftSlice(end: index)
        return leftSlice.utf16.count
    }
}
