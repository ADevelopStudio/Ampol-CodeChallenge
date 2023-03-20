//
//  AmpolTests.swift
//  AmpolTests
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import XCTest
@testable import Ampol

final class AmpolTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testApi() async {
        //        await self.testAPI(service: ConnectionManager()) //THIS ONE WILL FAIL BACAUSE THERE'S NO REAL API
        await self.testAPI(service: MockedNetworkManager())
    }
    
    
    func testAPI(service: NetworkService) async {
        let promiseFetchDashboardDataset = expectation(description: "fetchDashboardDataset is correct")
        let promiseFetchLastChargingSessions = expectation(description: "fetchLastChargingSessions is correct")
        let promiseFetchLastFuelTransactions = expectation(description: "fetchLastFuelTransactions is correct")
        
        do {
            let _ = try await service.fetchDashboardDataset()
            promiseFetchDashboardDataset.fulfill()
        } catch {
            print("Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        do {
            let _ = try await service.fetchLastChargingSessions()
            promiseFetchLastChargingSessions.fulfill()
        } catch {
            print("Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        
        do {
            let _ = try await service.fetchLastFuelTransactions()
            promiseFetchLastFuelTransactions.fulfill()
        } catch {
            print("Error:", error)
            XCTFail(error.localizedDescription)
        }
        wait(for: [promiseFetchDashboardDataset, promiseFetchLastChargingSessions, promiseFetchLastFuelTransactions], timeout: 10)
    }
    
    
    func testDashboardViewModel() async {
        //TESTING GOOD PARTH
        let vm = DashboardViewModel(network: MockedNetworkManager())
        XCTAssertTrue(vm.fuelLoadingState == .loading)
        XCTAssertTrue(vm.fuelTransactions.isEmpty)
        
        XCTAssertTrue(vm.chargingLoadingState == .loading)
        XCTAssertTrue(vm.chargingSessions.isEmpty)
        
        XCTAssertTrue(vm.dashLoadingState == .loading)
        XCTAssertTrue(vm.dataset == nil)
        
        
        await vm.loadEverything()
        XCTAssertTrue(vm.fuelLoadingState == .idle)
        XCTAssertTrue(!vm.fuelTransactions.isEmpty)
        
        XCTAssertTrue(vm.chargingLoadingState == .idle)
        XCTAssertTrue(!vm.chargingSessions.isEmpty)
        
        XCTAssertTrue(vm.dashLoadingState == .idle)
        XCTAssertTrue(vm.dataset != nil)
    }
    
    func testDashboardViewModelErrorAPI() async {
        // Error in network call
        let error: Error = ServiceError.invalidUrl
        
        let vm = DashboardViewModel(network: FailedNetworkService(error: error))
        
        XCTAssertTrue(vm.fuelLoadingState == .loading)
        XCTAssertTrue(vm.fuelTransactions.isEmpty)
        
        XCTAssertTrue(vm.chargingLoadingState == .loading)
        XCTAssertTrue(vm.chargingSessions.isEmpty)
        
        XCTAssertTrue(vm.dashLoadingState == .loading)
        XCTAssertTrue(vm.dataset == nil)
        
        
        await vm.loadEverything()
        XCTAssertTrue(vm.fuelLoadingState == .failed(error))
        XCTAssertTrue(vm.chargingLoadingState == .failed(error))
        XCTAssertTrue(vm.dashLoadingState == .failed(error))
    }
    
    func testErrorAPI() async {
        // Error in network call
        let error: Error = ServiceError.generalFailure
        let badNetwork = FailedNetworkService(error: error)
        
        let promiseFetchDashboardDataset = expectation(description: "fetchDashboardDataset is NOT correct")
        let promiseFetchLastChargingSessions = expectation(description: "fetchLastChargingSessions is NOT correct")
        let promiseFetchLastFuelTransactions = expectation(description: "fetchLastFuelTransactions is NOT correct")
        
        do {
            let _ = try await badNetwork.fetchDashboardDataset()
            XCTFail(error.localizedDescription)
        } catch {
            promiseFetchDashboardDataset.fulfill()
        }
        
        do {
            let _ = try await badNetwork.fetchLastChargingSessions()
            XCTFail(error.localizedDescription)
        } catch {
            promiseFetchLastChargingSessions.fulfill()
        }
        
        
        do {
            let _ = try await badNetwork.fetchLastFuelTransactions()
            XCTFail(error.localizedDescription)
        } catch {
            promiseFetchLastFuelTransactions.fulfill()

        }
        wait(for: [promiseFetchDashboardDataset, promiseFetchLastChargingSessions, promiseFetchLastFuelTransactions], timeout: 5)
    }
    
    
    func testLocalisation() throws {
        FuelTransactionStrings.allCases.testLocalisation()
        FuelCarouselViewStrings.allCases.testLocalisation()
        ServiceErrorStrings.allCases.testLocalisation()
        FuelAllTransactionsViewStrings.allCases.testLocalisation()
        FuelSingleTransactionViewStrings.allCases.testLocalisation()
        ChargingSessionStrings.allCases.testLocalisation()
        ChargingSessionsViewStrings.allCases.testLocalisation()
        DashboardOthersViewStrings.allCases.testLocalisation()
        HomeUsageBillsViewStrings.allCases.testLocalisation()
        HomeUsageBillsChartViewStrings.allCases.testLocalisation()
        DashboardUpcomingBillViewStrings.allCases.testLocalisation()
        DashboardStoreOffersViewStrings.allCases.testLocalisation()
        DashboardViewStrings.allCases.testLocalisation()
        DashboardDataSetStrings.allCases.testLocalisation()
    }
    
}


extension Array where Element: RawRepresentable<String> {
    func testLocalisation() {
        self.forEach { $0.testLocalisation() }
    }
}

extension RawRepresentable where RawValue == String {
    fileprivate func testLocalisation() {
        XCTAssertTrue(localised != rawValue, "localised: \(localised) rawValue: \(rawValue)")
        XCTAssertTrue(rawValue.localised != rawValue, "rawValue.localised: \(rawValue.localised) rawValue: \(rawValue)")
        XCTAssertTrue(rawValue.localised == localised, "rawValue.localised: \(rawValue.localised) localised: \(localised)")
    }
}
