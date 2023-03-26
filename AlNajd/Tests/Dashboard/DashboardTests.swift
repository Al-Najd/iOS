//
//  DashboardTests.swift
//
//
//  Created by Ahmed Ramy on 11/02/2022.
//

import Common
import Nimble
import Quick
import XCTest
@testable import Dashboard
@testable import Entities

/// 1. Measure Performance of each test (Done)
/// 2. Test cases of ranges (Done)
/// 3. Test cases of individual metrics (TODO)
/// 4. Test cases of caching the calculations (TODO)
class DashboardTests: QuickSpec {
    override func spec() {
        describe("the dashboard") {
            describe("ability to generate analysis") {
                context("on comparing two different ranges") {
                    let emptyWeekSeeder: (inout [Date: [Deed]], Date) -> Void = { dictionary, date in
                        dictionary[date] = .faraaid
                    }

                    let maxedOutWeekSeeder: (inout [Date: [Deed]], Date) -> Void = { dictionary, date in
                        dictionary[date] = .faraaid.map { $0.changing { $0.isDone = true }}
                    }

                    let goodWeekSeeder: (inout [Date: [Deed]], Date) -> Void = { dictionary, date in
                        var deeds: [Deed] = .faraaid
                        (0 ... 3).forEach { deeds[$0].isDone = true }
                        dictionary[date] = deeds
                    }

                    let badWeekSeeder: (inout [Date: [Deed]], Date) -> Void = { dictionary, date in
                        var deeds: [Deed] = .faraaid
                        (0 ... 1).forEach { deeds[$0].isDone = true }
                        dictionary[date] = deeds
                    }

                    context("when previous range is empty and current range is not") {
                        let previousWeekFakeData = Date.now.adding(.day, value: -7).previousWeek
                            .reduce(into: [Date: [Deed]](), emptyWeekSeeder)
                        let currentWeekFakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]](), goodWeekSeeder)

                        let analysis = analyize(
                            currentRangeReport: .init(ranges: [.fard: currentWeekFakeData]),
                            previousRangeReport: .init(ranges: [.fard: previousWeekFakeData]))[0]

                        it("should have a good indicator") {
                            expect(analysis.isImproving).to(beTrue())
                        }
                    }

                    context("when current range is better than the previous") {
                        let previousWeekFakeData = Date.now.adding(.day, value: -7).previousWeek
                            .reduce(into: [Date: [Deed]](), badWeekSeeder)
                        let currentWeekFakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]](), goodWeekSeeder)

                        let analysis = analyize(
                            currentRangeReport: .init(ranges: [.fard: currentWeekFakeData]),
                            previousRangeReport: .init(ranges: [.fard: previousWeekFakeData]))[0]

                        it("should have a good indicator") {
                            expect(analysis.isImproving).to(beTrue())
                        }
                    }

                    context("when previous range is better than the current") {
                        let previousWeekFakeData = Date.now.adding(.day, value: -7).previousWeek
                            .reduce(into: [Date: [Deed]](), goodWeekSeeder)
                        let currentWeekFakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]](), badWeekSeeder)

                        let analysis = analyize(
                            currentRangeReport: .init(ranges: [.fard: currentWeekFakeData]),
                            previousRangeReport: .init(ranges: [.fard: previousWeekFakeData]))[0]

                        it("should label the user's performance as improving") {
                            expect(analysis.isImproving).to(beFalse())
                        }
                    }

                    context("when both ranges are the same") {
                        let previousWeekFakeData = Date.now.adding(.day, value: -7).previousWeek
                            .reduce(into: [Date: [Deed]](), goodWeekSeeder)
                        let currentWeekFakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]](), goodWeekSeeder)

                        let analysis = analyize(
                            currentRangeReport: .init(ranges: [.fard: currentWeekFakeData]),
                            previousRangeReport: .init(ranges: [.fard: previousWeekFakeData]))[0]

                        it("should label the user's performance as improving for keeping his performance") {
                            expect(analysis.isImproving).to(beTrue())
                        }
                    }

                    context("when the current is maxed out") {
                        let previousWeekFakeData = Date.now.adding(.day, value: -7).previousWeek
                            .reduce(into: [Date: [Deed]](), badWeekSeeder)
                        let currentWeekFakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]](), maxedOutWeekSeeder)

                        let analysis = analyize(
                            currentRangeReport: .init(ranges: [.fard: currentWeekFakeData]),
                            previousRangeReport: .init(ranges: [.fard: previousWeekFakeData]))[0]

                        // TODO: - Change isImproving to an enum or struct so you can scale it better
                        it("should label the user's performance as improving") {
                            expect(analysis.isImproving).to(beTrue())
                        }
                    }
                }

                context("on ranges") {
                    context("when no sufficient data") {
                        context("where atleast 1 per each date has a deed done") {
                            let fakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]]()) { dictionary, date in
                                dictionary[date] = .faraaid
                            }

                            let analysis = analyize(currentRangeReport: .init(ranges: [.fard: fakeData]))[0]

                            it("shouldn't include ranges") {
                                expect(analysis.reports).to(beEmpty())
                            }

                            it("should tell user that no sufficient data for this") {
                                expect(
                                    analysis.insight?.indicator.id).to(
                                    equal(
                                        Insight.Indicator.encourage.id))
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
                                    dictionary[date] = .faraaid.map { $0.changing { $0.isDone = $0 == .fajr }}
                                }

                                let insight = fajrPraiser(.fard, fakeData)
                                expect(insight).toNot(beNil())
                                guard let insight = insight else { return }
                                expect(insight.indicator.id).to(be(Insight.Indicator.praise.id))
                            }
                        }
                    }

                    context("Al Fajr & Aishaa") {
                        it("should motivate the user by mentioning u did qeyam al layl") {
                            let fakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]]()) { dictionary, date in
                                dictionary[date] = .faraaid.map { $0.changing {
                                    $0.isDone = $0.title == Deed.fajr.title || $0.title == Deed.aishaa.title
                                }}
                            }

                            let insight = fajrAndAishaaPraiser(.fard, fakeData)
                            expect(insight).toNot(beNil())
                            guard let insight = insight else { return }
                            expect(insight.indicator.id).to(be(Insight.Indicator.praise.id))
                        }
                    }
                }
            }
        }
    }
}
