//
//  FuelAllTransactionsView.swift
//  Ampol
//
//  Created by Dmitrii Zverev on 19/3/2023.
//

import SwiftUI

struct FuelAllTransactionsView: View {
    var transactions: [FuelTransaction]
    
    var body: some View {
        List(transactions) { transaction in
            NavigationLink {
                FuelSingleTransactionView(transaction: transaction)
            } label: {
                HStack {
                    Text(transaction.date)
                        .font(.subheadline)
                    Spacer()
                    Text(transaction.price)
                        .font(.footnote)
                        .foregroundColor(.accentColor)
                }
            }
        }
        .padding(.top, -30)
        .navigationTitle(FuelAllTransactionsViewStrings.title.localised)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FuelAllTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FuelAllTransactionsView(transactions: Mock.fuelTransactions)
        }
        .preferredColorScheme(.dark)
    }
}

enum FuelAllTransactionsViewStrings: String, CaseIterable {
    case title = "FuelAllTransactionsView_Title" //"Fuel transactions";
}
