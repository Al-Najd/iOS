//
//  DashboardTests.swift
//  
//
//  Created by Ahmed Ramy on 11/02/2022.
//

import XCTest
import Quick
import Nimble
@testable import Entities
@testable import Dashboard

class DashboardTests: QuickSpec {
    override func spec() {
        describe("the dashboard") {
            describe("ability to generate analysis") {
                context("on ranges") {
                    context("when no sufficient data") {
                        context("where atleast 1 per each date has a deed done") {
                            let fakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]]()) { dictionary, date in
                                dictionary[date] = .faraaid
                            }
                            
                            let analysis = analyize(.init(ranges: [.fard: fakeData]))
                            
                            it("shouldn't include ranges") {
                                expect(analysis.map { $0.reports }).to(beEmpty())
                            }
                            
                            it("should tell user that no sufficient data for this") {
                                expect(
                                    analysis
                                        .filter { $0.reports.isEmpty }
                                        .compactMap { $0.insight?.indicator.id }
                                        .first
                                ).to(
                                    equal(
                                        Insight.Indicator.tipOfTheDay.id
                                    )
                                )
                            }
                        }
                    }
                }
            }
            
            describe("ability to give insights") {
                context("on praying") {
                    context("Al Fajr") {
                        context("multiple times") {
                            it("should praise him, mentioning the dates") {
                                let fakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]]()) { dictionary, date in
                                    dictionary[date] = .faraaid.map {
                                        $0.changing { $0.isDone = $0 == .fajr ? true : $0.isDone }
                                    }
                                }
                                
                                let insight = fajrPraiser(.fard, fakeData)
                                expect(insight).toNot(beNil())
                                expect(insight!.indicator.id).to(be(Insight.Indicator.praise.id))
                            }
                        }
                    }
                }
            }
        }
    }
}

protocol Changeable {}
extension Changeable {
    func changing(_ change: (inout Self) -> Void) -> Self {
        var a = self
        change(&a)
        return a
    }
}

extension Deed: Changeable {}

extension Array: Changeable where Element == Deed {}
