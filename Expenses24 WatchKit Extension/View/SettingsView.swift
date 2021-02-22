//
//  SettingsView.swift
//  Expenses24
//
//  Created by jassak on 21/02/2021.
//  Copyright © 2021 jassak1. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var passingData:PassingData
    var body: some View {
        List{
            Picker("Currency",selection:$passingData.currency){
                Image(systemName: "dollarsign.circle").tag("dollar")
                Image(systemName: "lirasign.circle").tag("lira")
                Image(systemName: "eurosign.circle").tag("euro")
            }
            VStack(alignment: .leading) {
                Text("Daily budet")
                Text("\(passingData.currencyList[passingData.currency] ?? "dollar") \(String(format: "%g",passingData.budget))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Slider(value:$passingData.budget,in:0...200,step:5)
                    .accentColor(.pink)
                    .background(Color.black)
            }
        }.font(.headline).onAppear(perform: {
            passingData.setDefaults()
        }).navigationBarTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(passingData: PassingData())
    }
}
